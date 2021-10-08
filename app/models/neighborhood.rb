class Neighborhood < ActiveRecord::Base
  belongs_to :city
  has_many :listings
 

  extend Reservable::Class_methods
  include Reservable::Instance_methods
 
   def neighborhood_openings(start_date, end_date)
     listings.select do |listing|
       listing.reservations.all? do |reservation|
         end_date < reservation.checkin.to_s || start_date > reservation.checkout.to_s 
       end
     end
   end 

end
