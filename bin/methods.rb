require_relative '../config/environment.rb'
require 'pry'

# As a user, I want to enter in an Artist and find events in NYC by that Artist" #R
def display_output 
    self.each_with_index
end

def price_comparison
    #return list of events with index
    #ask user for input to select an event
    #return prices (TM/SG/DIFF)
    puts  Events.each_with_index {|event, index| "#{index}|"}
    gets.chomp
end

def find_nyc_events_by_artist(artist)
    event = Event.find_by artist_name: artist
    display_to_user(event)
end

def find_nyc_events_by_venue(venue)
    Event.select do |event|
        event[:venue] == venue
    end
end

def all_nyc_venues
    Venue.select do |venue|
        venue[:city] == "New York"
    end
end

def add_to_favorites
    @event.create
end

def delete_a_favorite
    @event.destroy
end

def delete_all_favorites
    Favorite.destroy_all
end 

# puts "3. Create a favorites list" #C
# puts "4. Edit your favorites list" #U
# puts "5. Delete your favorites list" #U
