require 'sinatra'
require_relative '../Repository/ProductRepo'
require_relative '../Model/productModel'
require_relative '../ES_Product_Service/ProductServices'
class Services

  def initialize
    @es_products = ES_Product_Service.new
  end

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
    saved_product = Product.add(product)
    begin
      @es_products.es_add_product(saved_product)
    rescue => e
      LOGGER.error("elasticsearch is failing #{e.message}")
    end
    saved_product
  rescue Mongoid::Errors::Validations => e
    raise e
  rescue => e
    # E11000 is mongodb error code for dublicate fields
    if e.message.include?("E11000")
      raise e
    else
      raise
    end
  end

  def update_product(id , updates)
    product = Product.get_one(id)
    return nil unless product

    Product.update(id , updates)
  end

  def delete_product(id)
    Product.delete(id)
    @es_products.es_delete_product(id)
  rescue Mongoid::Errors::DocumentNotFound => e
    nil
  end

  def search(query)
    @es_products.es_search_product(query)
  end

  def delete_all
    Product.delete_all
    {message: "deleted successfully"}.to_json
  end
end