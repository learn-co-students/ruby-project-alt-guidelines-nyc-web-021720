class Favorite < ActiveRecord::Base
    belongs_to :event
    belongs_to :user
    #attr_accessor :event_name
end