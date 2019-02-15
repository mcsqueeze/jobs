class Option
  attr_reader :id, :rental_id, :type

  def initialize(id, rental_id, type)
    @id = id
    @rental_id = rental_id
    @type = type
  end

  def self.all
    data = Input.new.inputoptions
    @options = data.map do |o|
      Option.new(o[:id], o[:rental_id], o[:type])
    end
  end

  def self.group_by_rental(r_id)
    all
    @options.select { |option| option.rental_id == r_id.to_i }
  end

  def self.types(r_id)
    group_by_rental(r_id).map { |option| option.type }
  end

  def self.gpscost(rental_id)
    rental = Rental.find_by_id(rental_id)
    days = rental.numberofdays
    days * GPS * (rental.has_option?('gps') ? 1 : 0)
  end

  def self.babyseatcost(rental_id)
    rental = Rental.find_by_id(rental_id)
    days = rental.numberofdays
    days * BABY_SEAT * (rental.has_option?('baby_seat') ? 1 : 0)
  end

  def self.addinsurancecost(rental_id)
    rental = Rental.find_by_id(rental_id)
    days = rental.numberofdays
    days * ADD_INSURANCE * (rental.has_option?('additional_insurance') ? 1 : 0)
  end
end
