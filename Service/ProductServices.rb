require 'sinatra'
require_relative '../Repository/ProductRepo'
require_relative '../Model/productModel'

class Services

  # def initialize
  #   @repo = Repository.getInstance
  # end

  def get_all_product
    Product.get_all # same array of product object id is returned
  end

  def get(id)
    Product.get_one(id) # gets the product object or else returns nil
    # puts product
  rescue Mongoid::Errors::DocumentNotFound
    nil
  end

  def add_product(product) # the product is just the ruby hash not json
    Product.add(product)
  end

  def update_product(id , updates)
    Product.update(id , updates)
  end

  def delete_product(id)
    Product.delete(id)
  end
end