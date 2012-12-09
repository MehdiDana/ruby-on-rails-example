require 'test_helper'

class StateTest < ActiveSupport::TestCase
  context "customer should exist" do 
	setup do
	  @customer = Factory(:customer)
	end
	
	context "create contract" do 
	  setup do
		@contract = Contract.create(:customer => @customer)
	  end

	  should " be in state :pending when been generated " do
		assert @contract.state == 'pending', "initial state is ok"
	  end

	  should " should have a valid state " do
		assert @contract.state == 'pending', "initial state is ok" # precondition

#		assert @contract.reject! # be aware of !
#		assert @contract.state == 'reject', "reject transition in an incorrect state" #now its in state reject

		assert @contract.agreed! # be aware of !
		assert @contract.state == 'agreed', "agreed transition in an incorrect state" #now its in state agreed

		assert @contract.invoiced! # be aware of !
		assert @contract.state == 'invoiced', "invoiced transition in an incorrect state" #now its in state invoiced

		assert @contract.overdue! # be aware of !
		assert @contract.state == 'overdue', "overdue transition in an incorrect state" #now its in state overdue

		assert @contract.completed! # be aware of !
		assert @contract.state == 'completed', "completed transition in an incorrect state" #now its in state completed
	  end
	end
  end
end
