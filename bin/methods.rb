require_relative '../config/environment.rb'
require 'pry'

def find_events_by_artist(artist)
    event = Event.find_by artist_name: artist
    display_to_user(event)
end

def price_comparison_by_artist(artist)
    event = Event.find_by artist_name: artist
    display_price_comparison(event)
end

def price_comparison_by_event(event)
    found_event = Event.find_by event_name: event
    display_price_comparison(found_event)
end

def find_events_by_venue(venue)
    event = Event.find_by venue_name: venue
    display_to_user(event)    
end

def all_artist_names_through_events
    Event.all.each_with_index do |event, index| 
        puts "#{index + 1}. #{event.artist_name}"
    end
end

def find_events_by_state(state)
    Venue.select do |venue|
        venue.state == state
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

