

class Restaurant
  attr_reader :name,
              :address

  def initialize(data)
    @name = data[:name]
    @address = full_address(data)
  end

  def full_address(data)
    data[:location][:address1] + ", " + data[:location][:address2] + ", " + data[:location][:city] + ", "  +  data[:location][:state]  + " " + data[:location][:zip_code]
  end
end