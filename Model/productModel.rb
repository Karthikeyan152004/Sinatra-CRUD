class Product
  # this command makes this object of this class as separate document
  include Mongoid::Document

  # this command creates extra created_at and updated_at timestamps automatically
  include Mongoid::Timestamps

  # this defines what field we need and its data types
  field :name, type: String
  field :price, type: Integer
  field :is_available, type: Mongoid::Boolean, default: true
  field :description, type: String

  # this defines validations before storing this field into db
  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :is_available, inclusion: { in: [true, false] } , presence: true

  index({name:1})

  def self.get_all
    Product.all
  end

  def self.get_one(id)
    Product.find(id)
  end

  def self.add(product)
    Product.create!(product)
  end


  def self.delete(id)
    Product.find(id).destroy

  end

  def self.update(id, product)
    updated_product = Product.find(id)
    updated_product.update!(product)
    updated_product
  end

  def to_h
    {
      id: id.to_s,
      name: name,
      price: price,
      is_available: is_available
    }
  end
end
