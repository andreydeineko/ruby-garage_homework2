# TASK

# Describe the mail sorting (city, street, house, apartment, destination, value). 
# Write a program that determines: 
# 1) the number of parcels sent to some city 
# 2) how many parcels with value higher than 10 were sent 
# 3) what is the most popular address


class MailSorting

  attr_accessor :city, :street, :house, :apartment, :destination, :value

  def initialize(city, street, house, apartment, destination, value)
    @city, @street, @house, @apartment, @destination, @value = city, street, house, apartment, destination, value
  end

  def self.number_of_parcels_sent_to_city(parcels, city)
    parcels.select { |parcel| parcel.city == city }.count
  end

  def value_greater_then_10?
    value > 10
  end

  def self.amount_of_parcels_with_value_greater_then_10_were_sent(*parcels)
    parcels.select { |parcel| parcel.value_greater_then_10? }.count
  end

  def self.most_popular_address(*parcels)
    stats = parcels.inject({}) do |memo, parcel|
      memo[parcel.street] ||= 0
      memo[parcel.street] += 1
      memo
    end

    max_streets_count = stats.max_by { |key, value| value }.last
    addresses           = parcels.map(&:street)

    addresses.find { |street| stats[street] == max_streets_count }
  end

end