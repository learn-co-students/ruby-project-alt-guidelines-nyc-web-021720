require_relative '../config/environment.rb'
require 'pry'

def find_events_by_artist(artist)
    event = Event.find_by artist_name: artist
    display_to_user(event)
end

def find_event_by_id(id)
    Event.find_by id: id
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

def display_list_of_events
    Event.all.each_with_index do |event, index| 
        puts "#{index + 1}. #{event.artist_name} at #{event.venue_name} on #{event.event_date}"
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


def display_price_comparison(event)
    binding.pry
    puts
    puts "Event: #{event.event_name}"
    puts "Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts "Date: #{event.event_date}"
    puts
    puts 
    if event.ticketmaster_price_min > event.seatgeek_price_min
        puts "If you're looking for a more economical price for this event,"
        puts "StubMaster's patented Price Comparison App recommends buying tix from"
        puts "Ticketmaster."
    elsif event.ticketmaster_price_min < event.seatgeek_price_min
        puts "If you're looking for a more economical price for this event,"
        puts "StubMaster's patented Price Comparison App recommends buying tix from"
        puts "SeatGeek."
    elsif event.ticketmaster_price_max > event.seatgeek_price_max
        puts "If you're looking to ball out for this event but are the type to use coupons"
        puts "when you go food shopping, StubMaster's patented Price"
        puts "Comparison App recommends buying tix from SeatGeek."
    elsif event.ticketmaster_price_max < event.seatgeek_price_max
        puts "If you're looking to ball out for this event but are the type to use coupons"
        puts "when you go food shopping, StubMaster's patented Price"
        puts "Comparison App recommends buying tix from Ticketmaster."
    end
end


def would_you_like_to_favorite?
    puts
    puts "Would you like to save this event to your Favorites List?"
    puts "Let us know by typing Yes or No:"
    puts
    input = gets.chomp.downcase 
    if input == yes 
        add_to_favorites(event, @current_user)
    else 
        next_option
    end 
end