require 'json'
require 'date'
require 'pp'

require_relative 'car'
require_relative 'input'
require_relative 'rental'

FILEPATH = 'data/input.json'

def generate_json
  @array = []
  Rental.all.each do |rental|
    @array.push(id: rental.id, price: rental.price)
  end
  JSON.pretty_generate(rentals: @array)
end

puts generate_json
