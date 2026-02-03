Given("I visit the home page") do
  visit '/' # this where capybara is used
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end
