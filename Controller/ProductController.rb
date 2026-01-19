require 'sinatra/base'
require 'sinatra'
require_relative '../Service/ProductServices'
require_relative '../Helpers/Helper'

class Controller < Sinatra::Base
  helpers Json_body_parser

  # gets all the product from the db or list
  before do
    @service = Services.new
    content_type :json
  end
  # def initialize(*args)
  #   super
  #   @service = Services.new
  # end

  get '/products' do
    products = @service.get_all_product
    puts products
    products.map(&:as_json).to_json # just converting every object into hash and converting it to json and then returning it
  end

  # get single product
  get '/product/:id' do

    id = params['id']
    product = @service.get(id)
    halt 404, {error:"no product with such id"}.to_json unless product
    product.to_h.to_json

  end

  post '/product' do

    product = json_body # reading the json body and changes it into a ruby object or hash
    # puts product
    # serialize(json_body)
    saved_product = @service.add_product(product)
    puts saved_product
    halt 400 , {error: "some error"}.to_json unless saved_product
    saved_product.to_h.to_json
  end

  # update the existing product
  patch '/product/:id' do
    id = params["id"]
    updates = json_body

    puts "this is the update = #{updates.to_json}"
    updated_product = @service.update_product(id , updates)

    # {response:"the product of id: #{params['id']} has been successfully updated"}.to_json
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

end