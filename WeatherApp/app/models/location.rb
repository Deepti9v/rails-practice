class Location < ApplicationRecord
  #attr_accessible :address, :latitude, :longitude
  geocoded_by :address
  after_validation :geocode , if: ->(obj){ obj.address.present? and obj.address_changed? }
end
