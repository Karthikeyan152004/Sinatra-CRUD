require_relative '../Model/productModel'
class Repository
  def initialize
    @products = []
  end


  def self.getInstance
    @instance ||= new
  end

  def getAll
    # puts "hitting"
    # print @products
    puts "product is returned no worries!!"
    @products # returns product object probably just array of object IDs

  end

  def getOne(id)
    @products.find { |p| p.id == id.to_i } # it tries to find a match, if it finds returns the object or else nil
  end

  def add(product)
    # puts "it is in repository"
    new_product = Product.new(product["id"] , product["name"] , product["price"])

    @products << new_product
    true
  end
  # def find(id)
  #   @products.each_with_index do |payload , index|
  #     return index if payload.id == id
  #   end
  # end

  def delete(product)
    @products.delete(product)
  end
end