class Customer < ActiveRecord::Base
	has_many :contracts, :dependent => :destroy
	has_many :invoices, :dependent => :destroy

	has_many :payments, :through => :invoices
	has_many :shipments, :through => :contracts

#		validates :name, :address, :telephone, :presence => true
#		validates_format_of :email, :with => /^([a-zA-Z0-9_\-\.]+)@([a-zA-Z0-9_\-\.]+)$/

	# search in customer
	def self.search(search)
  		if search
  		  find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
 		 else
  		  find(:all)
  		end
	end

end
