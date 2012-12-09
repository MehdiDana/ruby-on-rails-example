class Invoice < ActiveRecord::Base
 	belongs_to :customer
  	belongs_to :contract

	has_many :payments, :dependent => :destroy

	validates_numericality_of :amount
end
