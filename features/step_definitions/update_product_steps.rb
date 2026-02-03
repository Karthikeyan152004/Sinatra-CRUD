Given(/^product "([^"]*)" of price (\d+) exists$/) do |product_name, price|
  Product.create!(name: product_name, price: price, is_available: true)
end

When(/^user updates price of "([^"]*)" to (\d+)$/) do |product_name, price|
  product = Product.find_by(name: product_name)
  page.driver.put(
    "/product/#{product.id}",
    {price: price}.to_json,
    {"CONTENT_TYPE" => "application/json"}
  )
end

Then(/^product "([^"]*)" should have price (\d+)$/) do |product_name, price|
  product = Product.find_by(name: product_name)
  expect(product.price.to_i).to eq(price.to_i)
end