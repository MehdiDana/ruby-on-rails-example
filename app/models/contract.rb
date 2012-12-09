class Contract < ActiveRecord::Base
  	belongs_to :customer
	has_many :invoices, :dependent => :destroy
	has_many :shipments

	validates_presence_of :state	
#	validates_numericality_of :price
#	validates_presence_of :policy, :reason

	def self.search(search)
  		if search
  		  find(:all, :conditions => ['reason LIKE ?', "%#{search}%"])
 		 else
  		  find(:all)
  		end
	end
	

  include ActiveRecord::Transitions

	state_machine do
		state :pending		# initial
		state :reject		#
		state :agreed 		# go to invoiced state
		state :overdue		# may send email
		state :invoiced		# expext the payments
		state :completed	# done


	  event :reject do 
		transitions :to => :reject, :from => [:pending], :on_transition => :finishhh
	  end

	  event :agreed do
		transitions :to => :agreed, :from => [:pending]
	  end 

	  event :invoiced do
		transitions :to => :invoiced, :from => [:agreed], :on_transition => :mk_invoice
	  end

	  event :overdue do
		transitions :to => :overdue, :from => [:invoiced]
	  end

	  event :completed do
		transitions :to => :completed, :from => [:invoiced, :overdue]
	  end

	end 

	private 
	  def finishhh	
		@shipment.destroy
	  end
	
	private 
	  def mk_invoice	
		Invoice.new
	  end
end
