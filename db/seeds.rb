# version: v1.0

# NOTES:
#  1) this seed data generates random model instances for populating your #milestone2 coursework databases
#  2) contract and shipment states are randomly chosen and so may not be states #that a live application would generate (be warned!)
#  3) relationships are sometimes built by the view side of the application and so #we will need to perform testing to ensure that they are correct!

max_vehicle_volume = 10**6 # litres
max_vehicle_weight = 10**2 # metric tonnes
max_shipment_size = 5 # number of full lorries

# We'll modify the Faker::Address class and add in a new method
class Faker::Address
  def self.address
    address = [self.street_address]
    address << self.secondary_address if rand(3) == 0
    address << self.city
    address << self.us_state
    address << self.uk_postcode
    address.join("\n")
  end
end

# We'll create a new Faker::Date class for generating random dates
class Faker::Date
  def self.date(params={})
      years_back = params[:year_range] || 5
      year = (rand * (years_back)).ceil + (Time.now.year - years_back)
      month = (rand * 12).ceil
      day = (rand * 31).ceil
      series = [date = Time.local(year, month, day)]
      if params[:series]
        params[:series].each do |some_time_after|
          series << series.last + (rand * some_time_after).ceil
        end
        return series
      end
      date    
  end
end

Factory.define :customer do |t|
  t.name { Faker::Company.name }
  t.address { Faker::Address.address }
  t.telephone { Faker::PhoneNumber.phone_number }
  t.email { Faker::Internet.email }
end

(1..20).each do
  Factory(:customer)
end


Factory.define :vehicle do |t|
  t.volume { 1+rand(max_vehicle_volume) }
  t.weight_capacity { 1+rand(max_vehicle_weight) }
end

(1..5).each do
  Factory(:vehicle, :type => [:flat_bed, :lorry, :box_van, :car].map { |t| t.to_s.camelize }.rand)
end


Factory.define :driver do |t|
  t.name { Faker::Name.name }
  t.address { Faker::Address.address }
  t.telephone { Faker::PhoneNumber.phone_number }
  t.licenses { (0..rand(5)).map { |n| License.create(:type => [:code_b, :code_c1, :code_c].map { |t| t.to_s.camelize }.rand) } }
end

(1..10).each do
  Factory(:driver)
end



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

Factory.define :delivery do |t|
  # intentionally empty!
end

Factory.define :shipment do |t|
  t.origin { Faker::Address.address }
  t.destination { Faker::Address.address }
  t.description { Faker::Lorem.sentences(1+rand(10)).join("\n") }
  t.weight { 1+rand(max_vehicle_weight * rand(max_shipment_size)) }
  t.volume { 1+rand(max_vehicle_volume * rand(max_shipment_size)) }
  t.contract { Contract.all.rand }
  t.vehicle { Vehicle.all.rand }
  t.driver { Driver.all.rand }
  t.state { [:pending, :delivered].rand }
  t.slot_start_at { |s| s.contract.start_at + rand(s.contract.end_at - s.contract.start_at) unless s.contract.start_at.nil? or [:pending, :reject].member? s.state }
  t.slot_end_at { |s| s.slot_start_at + rand(s.contract.end_at - s.slot_start_at) unless s.slot_start_at.nil? }
  t.delivery { |s| ((s.slot_start_at.nil? or s.state == :pending) ? Factory(:delivery) : Factory(:delivery, :shipped_at => s.slot_start_at + rand(s.slot_end_at - s.slot_start_at))) unless s.state == :reject }
end

(1..30).each do
  Factory(:shipment)
end
