ENV['RACK_ENV'] = 'test'

require 'capybara'
require 'capybara/cucumber'
require 'rspec/expectations'

require_relative '../../Server'

Capybara.app = Product_App

# Before do
#   Product.delete_all
# end