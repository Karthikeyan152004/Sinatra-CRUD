require_relative "../spec_helper"

# Feature:
RSpec.describe 'POST /products' do
  # when post request 2 possible scenarios 1. valid payload 2. invalid product
  # Scenario
  context "when payload is valid" do
    # Step - 1
    it "creates a product" do
      post "/product" , {name: "Rspec_test_1" , price: 1000, is_available: true}.to_json ,{"CONTENT_TYPE" => "application/json"}
      expect(last_response.status).to eq(200)
      body = JSON.parse(last_response.body)

      expect(body).to include('_id' , 'name' => 'Rspec_test_1' , 'price' => 1000, 'is_available' => true)
    end

    # Step - 1
    context "when payload is invalid" do
      it "creates a product" do
        post "/product" , {price: 1000, is_available: true}.to_json ,{"CONTENT_TYPE" => "application/json"}
        expect(last_response.status).to eq(400)
      end
    end
  end
end
