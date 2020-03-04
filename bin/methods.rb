require_relative '../config/environment.rb'

# As a user, I want to enter in an Artist and find events in NYC by that Artist" #R

def all_nyc_venues
    Venue.select do |venue|
        venue[:city] == "New York"
    end
end

def find_nyc_events_by_artist(artist)
    Event.select do |event|
        event[:artist_name] == artist
    end
end

def find_nyc_events_by_venue(venue)
    Event.select do |event|
        event[:venue] == venue
    end
end

def add_to_favorites

end

def delete_a_favorite

end

def delete_all_favorites

end 

def price_comparison
    #return list of events with index
    #ask user for input to select an event
    #return prices (TM/SG/DIFF)
    

end


# puts "2. Find events in NYC by venue" #R
# puts "3. Create a favorites list" #C
# puts "4. Edit your favorites list" #U
# puts "5. Delete your favorites list" #U

