require 'test_helper'

class CustomersHelperTest < ActionView::TestCase
	Factory.define :customer do |t|
	  t.name { Faker::Company.name }
	  t.address { Faker::Address.address }
	  t.telephone { Faker::PhoneNumber.phone_number }
	  t.email { Faker::Internet.email }
	end
end
