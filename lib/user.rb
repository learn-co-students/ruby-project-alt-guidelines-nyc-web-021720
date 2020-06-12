class User < ActiveRecord::Base
    has_many :favorite
    has_many :event, through: :favorite
end