class Commission
  attr_reader :rental_id, :insurance_fee, :assistance_fee, :drivy_fee

  def initialize(rental_id)
    @rental_id = rental_id
  end

  def insurancefee
    rental = Rental.find_by_id(@rental_id)
    (rental.price * COMMISSION * INSURANCE).to_i
  end

  def assistancefee
    rental = Rental.find_by_id(@rental_id)
    (rental.numberofdays * ROADSIDE).to_i
  end

  def drivyfee
    rental = Rental.find_by_id(@rental_id)
    (rental.price * COMMISSION - insurancefee - assistancefee).to_i
  end
end
