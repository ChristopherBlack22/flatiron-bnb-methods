class Review < ActiveRecord::Base
  validates :rating, presence: true
  validates :description, presence: true
  validate :must_have_finished_reservation


  belongs_to :reservation
  belongs_to :guest, :class_name => "User"

  def must_have_finished_reservation
    if reservation == nil || reservation.status != "accepted" || reservation.checkout >= Time.now
      errors.add(:must_have_finished_reservation, "You cannot make a review until a reservation has been finished")
    end 
  end 

end
