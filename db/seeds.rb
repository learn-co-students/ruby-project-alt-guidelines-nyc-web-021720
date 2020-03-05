require_relative '../config/environment'
require_relative '../reference/tmresults'
require_relative '../reference/sgresults'


tmdata = $globtmdata
sgdata = $globsgdata




#Convert JSON results to values in the db
def create_artists(events)
        if getartists(events) == "Null" 
        elsif Artist.find_by(name: events["_embedded"]["attractions"][0]["name"])
            Artist.find_by(name: events["_embedded"]["attractions"][0]["name"])
        else
        artist_name = events["_embedded"]["attractions"][0]["name"]
        artist_genre = events["_embedded"]["attractions"][0]["classifications"][0]["genre"]["name"]
        Artist.create(:name => artist_name, :genre => artist_genre)
        end
end

def getartists(events)
    begin
    events["_embedded"]["attractions"][0]["name"]
    rescue
        "Null"
    end
end


def create_venues(events)
        if getvenues(events) == "Null"
        elsif Venue.find_by(name: events["_embedded"]["venues"][0]["name"])
            Venue.find_by(name: events["_embedded"]["venues"][0]["name"])
        else
            #name, city, state'=
            venue_name = events["_embedded"]["venues"][0]["name"]
        venue_city = events["_embedded"]["venues"][0]["city"]["name"]
        venue_state = events["_embedded"]["venues"][0]["state"]["name"]
        Venue.create(:name => venue_name, :city => venue_city, :state => venue_state)
        end
end

def getvenues(events)
    begin
    events["_embedded"]["venues"][0]["name"]
    rescue
        "Null"
    end
end

def ticket_min_handler(events)
    begin
    events["priceRanges"][0]["min"]
    rescue
        "Null"
    end
end

def ticket_max_handler(events)
    begin
    events["priceRanges"][0]["max"]
    rescue
        "Null"
    end
end


def create_events(events, artist_name, venue_name)
    event_name = events["name"]
    artist_name = artist_name
    venue_name = venue_name
    event_date = events["dates"]["start"]["localDate"]
    ticketmaster_price_min = ticket_min_handler(events)
    ticketmaster_price_max = ticket_max_handler(events)
    Event.create(:event_name => event_name, :artist_name=> artist_name, :venue_name => venue_name, :event_date => event_date, :ticketmaster_price_min => ticketmaster_price_min, :ticketmaster_price_max => ticketmaster_price_max)
end

def create_events_artists_and_venues(tmdata)
    tmdata["_embedded"]["events"].each do |events|
        #id, event_name, artist_name, venue_name, event_date, ticketmaster_price_min, seatgeek_price_min, price_difference_min, ticketmaster_price_max, seatgeek_price_max, price_difference_max, artist_id, venue_id
        artist_name = getartists(events)
        artist = create_artists(events)
        venue_name = getvenues(events)
        venue = create_venues(events)
        event = create_events(events, artist_name, venue_name)
        assign_fks(event, artist, venue)
    end
end

def assign_fks(event, artist, venue)
    begin 
        event.artist_id = artist.id
    rescue
        "Null"
    end
    begin 
        event.venue_id = venue.id
    rescue
        "Null"
    end
    event.save
end

def map_sg_data_to_events(sgdata)
    sgdata["events"].each do |events|
        artist_name = events["performers"][0]["name"]
        venue_name = events["venue"]["name"]
        event_date = events["datetime_local"].to_date
        check = check_matching_record(artist_name, venue_name, event_date)
        if check == 1
            event_instance = Event.find_by(artist_name: artist_name, venue_name: venue_name, event_date: event_date)
            update_event(events, event_instance)
        else
        end
    end
end

def check_matching_record(artist_name, venue_name, event_date)
    if Event.find_by(artist_name: artist_name, venue_name: venue_name, event_date: event_date)
        return 1
    else
        return 0
    end
end

def update_event(events, event_instance)
    begin
        event_instance.seatgeek_price_min = events["stats"]["lowest_price"]
    rescue 
    end
    begin 
        event_instance.price_difference_min = event_instance.seatgeek_price_min - event_instance.ticketmaster_price_min
    rescue
    end
    begin
    event_instance.seatgeek_price_max = events["stats"]["highest_price"]
    rescue
    end
    begin
        event_instance.price_difference_max = event_instance.seatgeek_price_max - event_instance.ticketmaster_price_max
    rescue
    end
        event_instance.save
end



#create_events_artists_and_venues(tmdata)

map_sg_data_to_events(sgdata)

#create_venues(tmdata)

#create_artists(tmdata)



# tmresults.each do |r|
#harry_stles = tmresults["_embedded"]["events"][4]["_embedded"]["attractions"][0]["name"] #this gets us to arry styles
#artist_list =
#event_list = tmresults["_embedded"]["events"]
##
#i = 0
#artist_list = []
#event_list.each_with_index do |event, index|
#    artist_list << event_list[index]["_embedded"]["attractions"][0]["name"]
#end




