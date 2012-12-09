require 'test_helper'

class CustomerTest < ActionController::IntegrationTest
  # customer CRUD test
  	context "CRUD actions" do
		should "be able to create" do
			get "/customers/new"
			assert_response :success
			post "/customers", :post => {}
			assert_redirected_to "/customers/#{assigns(:customer).id}"
		end

		context "non-empty Change model" do
			setup do
				@customer = Customer.first || Customer.create
			end

			should "be able to read" do
				get "/customers"
				assert_response :success
				get "customers/#{@customer.id}"
				assert_response :success
			end

			should "be able to update" do
				get "/customers/#{@customer.id}/edit"
				assert_response :success
				put "/customers/#{@customer.id}", :post => {}
				assert_redirected_to "/customers/#{@customer.id}"
			end

			should "be able to delete" do
				delete "/customers/#{@customer.id}"
				assert_redirected_to "/customers"
			end
		end 
  	end
end
