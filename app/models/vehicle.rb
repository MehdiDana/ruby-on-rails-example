class Vehicle < ActiveRecord::Base
	has_many :shipments
	
	validates_presence_of :type
	validates_numericality_of :volume, :less_than => 10**6	
	validates_numericality_of :weight_capacity, :less_than => 10**2
end

class Car < Vehicle
end


class Lorry < Vehicle
end



class FlatBed < Vehicle 
end



class BoxVan < Vehicle 
end
