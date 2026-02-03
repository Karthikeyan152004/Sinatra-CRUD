require 'sinatra/base'
require 'mongoid'
require 'mongo'
require_relative './Controller/ProductController'
require_relative './config/logger'

# this line tells ruby to load this elastic-search-client file where we created Elasticsearch client
require_relative './config/elastic-search-client'
require_relative './Service/IndexManager'

class Product_App < Sinatra::Base
  IndexManager.setup!

  use Controller
  # this command finds the mongoid.yml and picks the development environment => this is where we specify the database host,port which database everything
  Mongoid.load!("config/mongoid.yml", :development)

  # this line tells
  # puts Mongoid::Clients.default.database.command("database connected")


  get '/' do
    "Welcome to Poshmark144p"
  end

  Mongoid::Tasks::Database.create_indexes

end
