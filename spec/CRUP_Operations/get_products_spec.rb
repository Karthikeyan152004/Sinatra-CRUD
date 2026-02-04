require_relative '../spec_helper'

RSpec.describe 'GET /products' do
  context "user gets all products" do
    it "gets all products" do
      get '/products'
      expect(last_response.body.size).to be > 0
    end
  end
end