# populate class with input data + enable search of cars by id
class Car
  attr_reader :id, :price_per_day, :price_per_km

  def initialize(id, price_per_day, price_per_km)
    @id = id
    @price_per_day = price_per_day
    @price_per_km = price_per_km
  end

  def self.all
    data = Input.new.inputcars
    @cars = data.map do |c|
      Car.new(c[:id], c[:price_per_day], c[:price_per_km])
    end
  end

  def self.find_by_id(car_id)
    all
    @cars.select { |x| x.id == car_id.to_i }[0]
  end
end
