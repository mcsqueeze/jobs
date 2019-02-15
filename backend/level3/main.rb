require 'json'
require 'date'
require 'pp'

require_relative 'car'
require_relative 'input'
require_relative 'rental'
require_relative 'commission'

FILEPATH = 'data/input.json'
DISCOUNT_1 = 0.9    # => 10% discount on days 2, 3, 4
DISCOUNT_4 = 0.7    # => 30% discount on days 5, 6, 7, 8, 9, 10
DISCOUNT_10 = 0.5   # => 50% discount on days 11 and beyond
COMMISSION = 0.3    # => 30% commission taken off rental price
INSURANCE = 0.5     # => 50% of the commission goes to the insurance
ROADSIDE = 100      # => (euro cents per day) goes to the roadside assistance

def generate_json
  @array = []
  Rental.all.each do |rental|
    commission = Commission.new(rental.id)
    @array.push(
      id: rental.id,
      price: rental.price,
      commission: {
        insurance_fee: commission.insurancefee,
        assistance_fee: commission.assistancefee,
        drivy_fee: commission.drivyfee
      }
    )
  end
  JSON.pretty_generate(rentals: @array)
end

puts generate_json
