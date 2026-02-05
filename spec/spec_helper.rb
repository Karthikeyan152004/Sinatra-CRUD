ENV['RACK_ENV'] = 'test'

require 'rspec'

# this enables us to use Rack::Test
require 'rack/test'
require_relative '../Server'

# this mixes Rack::Test::Methods to every spec we run so that we can use last_response , last_request , get , post , put , delete
RSpec.configure do |config|
  config.include Rack::Test::Methods
end


# this app should return something that can respond to app.call(env)
# Sinatra apps are Rack apps as classes
# so Product_App.call is valid
# product_app.new.call is not valid

def app
  Product_App
end