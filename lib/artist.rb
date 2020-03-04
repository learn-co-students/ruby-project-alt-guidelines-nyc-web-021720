class Artist < ActiveRecord::Base
    has_many :event
    has_many :venue, through: :event
end