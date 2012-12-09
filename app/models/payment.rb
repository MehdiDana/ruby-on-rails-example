class Payment < ActiveRecord::Base
  belongs_to :invoice

	validates_numericality_of :amount
	validates_presence_of :invoice_id
end
