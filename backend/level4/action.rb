class Action

 # Class constant
  SETS = [
    ['driver', 'debit'],
    ['owner', 'credit'],
    ['insurance', 'credit'],
    ['assistance', 'credit'],
    ['drivy', 'credit']
  ].freeze

  attr_accessor :rental_id, :who, :type

  def initialize(attributes = {})
    @rental_id = attributes[:rental_id]
    @who = attributes[:who]
    @type = attributes[:type]
  end

  def find_rental(rental_id)
    @rental = Rental.find_by_id(rental_id)
  end

  def self.all
    list = []
    SETS.each do |set|
      list.push(Action.new(who: set[0], type: set[1]))
    end
    list
  end

  def amount
    find_rental(@rental_id)
    case @who
    when 'driver' then @rental.price
    when 'owner' then @rental.price - Commission.new(@rental.id).totalfees
    when 'insurance' then Commission.new(@rental.id).insurancefee
    when 'assistance' then Commission.new(@rental.id).assistancefee
    when 'drivy' then Commission.new(@rental.id).drivyfee
    end
  end
end
