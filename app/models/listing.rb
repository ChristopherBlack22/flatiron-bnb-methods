class Listing < ActiveRecord::Base
  validates :address, presence: true
  validates :listing_type, presence: true
  validates :title, presence: true
  validates :description, presence: true
  validates :price, presence: true
  validates :neighborhood, presence: true

  after_create :host_is_host
  after_destroy :is_host_still_host


  belongs_to :neighborhood
  belongs_to :host, :class_name => "User"
  has_many :reservations
  has_many :reviews, :through => :reservations
  has_many :guests, :class_name => "User", :through => :reservations
  

  def average_review_rating
    reviews.average(:rating)
  end

  private

  def host_is_host
    host.host = true
    host.save
  end 

  def is_host_still_host
    if host.listings.empty?
      host.host = false
      host.save
    end
  end 

end
