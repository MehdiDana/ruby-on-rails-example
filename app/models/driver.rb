class Driver < ActiveRecord::Base
	has_many :shipments
	has_many :licenses

	validates_presence_of :name, :address, :telephone

end
