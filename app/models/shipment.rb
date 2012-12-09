class Shipment < ActiveRecord::Base
  	belongs_to :driver
  	belongs_to :vehicle
  	belongs_to :contract
	
	has_one :delivery
 	has_and_belongs_to_many :licenses

	
	
	validates_presence_of :state, :origin, :destination, :description
	validates_numericality_of :weight, :volume
	validates_presence_of :contract_id, :driver_id, :vehicle_id


  include ActiveRecord::Transitions

	state_machine do
		state :pending	# initial 
		state :delivered

	  event :delivered do
		transitions :to => :delivered, :from => [:pending]
	  end

	end	

end
