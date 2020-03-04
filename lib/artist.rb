class Artist < ActiveRecord::Base
    has_many :event
    has_many :venues, through: :events
end