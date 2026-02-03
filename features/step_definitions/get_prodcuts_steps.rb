Given(/^product "([^"]*)" exist with the price (\d+)$/) do |product_name, price|
  Product.create!(name: product_name, price: price , is_available: true)
end

When(/^user fetches all the product$/) do
  page.driver.get("/products")
end

Then(/^response should contain the product "([^"]*)"$/) do |product_name|
  expect(page.body).to include product_name
end