class Coordinate < ApplicationRecord
  belongs_to :route
  acts_as_geolocated
end
