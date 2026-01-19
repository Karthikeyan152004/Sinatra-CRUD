require 'sinatra'
require 'mongoid'
require_relative './Controller/ProductController'


use Controller
# this command finds the mongoid.yml and picks the development environment => this is where we specify the database host,port which database everything
Mongoid.load!("config/mongoid.yml", :development)

# this line tells
# puts Mongoid::Clients.default.database.command("databaseconnected")


get '/' do
  "Welcome to Poshmark144p"
end
