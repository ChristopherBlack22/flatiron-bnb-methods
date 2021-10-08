class Reservation < ActiveRecord::Base
  validates :checkin, presence: true
  validates :checkout, presence: true
  validate :guest_and_host_not_the_same
  validate :available
  validate :checkin_is_before_checkout, if: [:checkout, :checkin]

  belongs_to :listing
  belongs_to :guest, :class_name => "User"
  has_one :review

  def duration
    (checkout-checkin).to_i
  end

  def total_price
    listing.price.to_f * duration
  end 

  def guest_and_host_not_the_same
    if listing.host == guest
      errors.add(:guest_and_host_not_the_same, "User cannot be both Guest and Host")
    end 
  end 

  def available
    if listing.reservations.all? do |reservation|
        checkout.to_s < reservation.checkin.to_s || checkin.to_s > reservation.checkout.to_s
      end
      #is available
    else
      errors.add(:available, "Listing is not available for these dates")
    end  
  end

  def checkin_is_before_checkout
    if checkout <= checkin
      errors.add(:checkin_is_before_checkout, "Checkin must be before Checkout, and not on the same day")
    end 
  end 

end
