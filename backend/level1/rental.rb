class Rental
  attr_reader :id, :car_id, :start_date, :end_date, :distance

  def initialize(id, car_id, start_date, end_date, distance)
    @id = id
    @car_id = car_id
    @start_date = start_date
    @end_date = end_date
    @distance = distance
  end

  def self.all
    data = Input.new.inputrentals
    @rentals = data.map do |r|
      Rental.new(r[:id], r[:car_id], r[:start_date], r[:end_date], r[:distance])
    end
  end

  def self.find_by_id(rental_id)
    all
    @rentals.select { |x| x.id == rental_id.to_i }[0]
  end

  def numberofdays
    startdate = Date.parse(@start_date.to_s)
    enddate = Date.parse(@end_date.to_s)
    (enddate - startdate).to_i + 1
  end

  def time_component
    car = Car.find_by_id(@car_id)
    car.price_per_day * numberofdays
  end

  def distance_component
    car = Car.find_by_id(@car_id)
    car.price_per_km * distance
  end

  def price
    (time_component + distance_component).round
  end
end
