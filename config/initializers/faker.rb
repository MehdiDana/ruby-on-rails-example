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
