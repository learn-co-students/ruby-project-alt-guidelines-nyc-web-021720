require_relative '../config/environment.rb'
require 'pry'

def display_list_of_events
    Event.all.each_with_index do |event, index| 
        puts "#{index + 1}. #{event.artist_name} at #{event.venue_name} on #{event.event_date}"
    end
end

# def display_list_of_events
#     sorted_events = Event.all.sort_by{|event|event.event_date}
#     sorted_events.all.each_with_index do |event, index| 
#         event_id = event.event_id
        
#         puts "#{index + 1}. #{event.artist_name} at #{event.venue_name} on #{event.event_date}"
#     end
# end

#the sorted list is out of order
#

def display_list_of_artists
    Artist.all.each_with_index do |artist, index| 
        puts "#{index + 1}. #{artist.name}"
    end
end

def find_events_by_artist(artist)
    artist_name = Artist.find(artist).name
    event = Event.find_by artist_name: artist_name
    display_to_user(event)
end


def display_list_of_venues
    Venue.all.each_with_index do |venue, index| 
        puts "#{index + 1}. #{venue.name} at #{venue.city}"
    end
end

def find_events_by_venue(venue)
    venue_name = Venue.find(venue).name
    event = Event.find_by venue_name: venue_name
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

def all_artist_names_through_events
    Event.all.each_with_index do |event, index| 
        puts "#{index + 1}. #{event.artist_name}"
    end
end


def would_you_like_to_favorite(event)
    puts
    puts "Would you like to save this event to your Favorites List?"
    puts "Let us know by typing Yes or No:"
    puts
    input = gets.chomp.downcase 
    if input == "yes" 
        add_to_favorites(event, current_user)
    else 
        main_menu
    end 
end


def add_to_favorites(event, current_user)
    userobj = User.find_by username: current_user
    Favorite.create(:username => current_user, :event_name => event.event_name, :user_id => userobj.id, :event_id => event.id)
end

def find_favorites_by_user(current_user)
    userobj = User.find_by username: current_user 
    Favorite.select do |favorites|
        favorites.user_id == userobj.id
    end
end

def find_one_favorite(current_user, id)
    userobj = User.find_by username: current_user 
    Favorite.select do |favorites|
        favorites.user_id == userobj.id
    end
end

def delete_favorite(current_user, number)
    favs = find_favorites_by_user(current_user)
    Favorite.delete(favs[number.to_i - 1]) 
end


