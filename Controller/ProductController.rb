require 'sinatra/base'
require 'sinatra'
require_relative '../Service/ProductServices'
require_relative '../Helpers/Helper'

class Controller < Sinatra::Base
  helpers Json_body_parser

  before do
    @service = Services.new
    content_type :json
  end


  get '/products/search?' do
    query = params[:q]
    res = @service.search(query)

    res.as_json.to_json
  end

  # gets all the product from the db or list
  get '/products' do
    products = @service.get_all_product
    products.map(&:as_json).to_json # just converting every object into hash and converting it to json and then returning it
  end

  # get single product
  get '/product/:id' do
    id = params['id']
    product = @service.get(id)
    halt 404, {error:"no product with such id"}.to_json unless product
    product.to_h.to_json
  end

  # by the end points itself we could determine that data from this body goes to products index
  post '/product' do
    product = json_body # reading the json body and changes it into a ruby object or hash
    serialize(product)
    saved_product = @service.add_product(product)
    saved_product.as_json.to_json
  rescue Mongoid::Errors::Validations => e
      status 400
      { error: e.message }.to_json
  rescue => e
      if e.message.include?("E11000")
        status 409
        { error: "Duplicate product" }.to_json
      else
        raise
      end
  end

  # update the existing product
  put '/product/:id' do
    # puts "request body: #{request.body.read}"
    id = params["id"]
    updates = json_body

    puts "updatessss => #{updates}"

    updated_product = @service.update_product(id , updates)
    halt 404, {error:"no product with such id"}.to_json unless updated_product
    updated_product.to_h.to_json
  end

  delete '/product/:id' do
    id = params["id"]
    deleted_product = @service.delete_product(id)
    if deleted_product
      { response:"the product of id: #{params['id']} has been successfully deleted!" }.to_json
    else
      halt 404 , {error:"Invalid Id or Id not found"}.to_json
    end
  end

  delete '/products' do
    @service.delete_all
  end

end