When /^user creates a product with name "([^"]*)" price (\d+) and availability as (true|false)$/ do |name, price, availability|
  # puts "name: #{name}, price: #{price}, availability: #{availability}"
  page.driver.post(
    "/product",
    {
      name: name,
      price: price,
      is_available: availability == "true" ? true : false,
    }.to_json,
    { "CONTENT_TYPE" => "application/json" }
  )

end

Then(/^product "([^"]*)" should be stored in the system$/) do |name|
  product = Product.find_by(name: name)
  puts "THE PRODUCT IS : #{product}"
  expect(product).not_to be_nil
end