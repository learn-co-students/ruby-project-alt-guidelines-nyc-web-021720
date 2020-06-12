class Venue < ActiveRecord::Base
    has_many :event
    has_many :artist, through: :event
end