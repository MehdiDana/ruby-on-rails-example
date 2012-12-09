require 'test_helper'

class ContractsHelperTest < ActionView::TestCase
	Factory.define :contract do |t|
	  t.customer { Customer.all.rand }
	  t.price { rand(10**4) }
	  t.policy { Faker::Company.catch_phrase }
	  t.reason { Faker::Lorem.sentence }
	end

	(1..15).each do
	  state = [:pending, :reject, :agreed, :overdue, :invoiced, :completed].rand
	  Factory(:contract, :state => state) if [:pending, :reject].member? state
	  dates = Faker::Date.date(:series => [1.year])
	  Factory(:contract, :state => state, :start_at => dates.first, :end_at => dates.last) unless [:pending, :reject].member? state
	end
end
