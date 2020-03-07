require_relative '../config/environment'

class CLI 

    attr_accessor :current_user, :event

    def initialize(current_user = nil)
        puts 
        puts "                      Welcome to....                             "
        puts "_________________________________________________________________"
        puts "      ___         ___                       ___                  "           
        puts       "/ _\ |_ _   _| |__  _ __ ___   __ _ ___| |_ ___ _ __"
        puts       "\ \| __| | | | '_ \| '_ ` _ \ / _` / __| __/ _ \ '__|"
        puts       "_\ \ |_| |_| | |_) | | | | | | (_| \__ \ ||  __/ |  " 
        puts       "\__/\__|\__,_|_.__/|_| |_| |_|\__,_|___/\__\___|_|  " 
        puts "_________________________________________________________________"                                                   
        puts
        puts        "Stubmaster is home of the world-famous Stubmaster"
        puts      "Price Comparison(TM) app. Compare prices and find out"
        puts   "about all the most fire events all throughout the Big Apple!"
        puts
        puts "_________________________________________________________________"
    end

    
    
    def log_in
        flag = 0
        until flag == 1
        puts
        puts "New user? Please press <1> to create a username."
        puts
        puts "Existing user? Welcome back! Enter your username below."
        puts 
        puts "Not feeling us? Type <exit> to close out the app!"
        puts
        input = gets.chomp
            if input == "1" 
                 create_username
                 flag = 1
            elsif User.find_by username: input 
                @current_user = input
                flag = 1
                main_menu
            elsif input == "exit"
                exit
            else
                puts
                puts "This is an invalid response"
                puts
            end      
        end
    end

    def create_username
        puts "Please enter your first name:"
        first_name = gets.chomp.capitalize
        puts "Please enter your last name:"
        last_name = gets.chomp.capitalize
        puts "Please enter your new username:"
        username = gets.chomp
        User.create(:first_name => first_name, :last_name=> last_name, :username => username)
        puts
        puts "Thanks! Your username is #{username}"
        puts
        log_in
    end

    def main_menu   
        puts
        puts "StubMaster Main Menu"
        puts "*-----------------------*"
        puts "1. StubMaster Price Comparison App TM" #R
        puts "2. Find events by artist" #R
        puts "3. Find events by venue"
        puts "4. Check your favorites" #R
        puts "5. Aight, I'mma head out."
        puts 
        input = STDIN.gets.chomp.downcase
        if input == "1"
            puts
            puts "Nice! This is what we're all about,"
            puts "after all. Select your event from the" 
            puts "following list:"
            puts
            puts
            display_list_of_events
            id = gets.chomp
            event = find_event_by_id(id)        
            # take input and return matching event
            # index 0 is id 1 and so on and so forth                
            display_price_comparison(event)          
        elsif input == "2" 
            puts "Which artist?"
            display_list_of_artists
            id = gets.chomp
            find_events_by_artist(id)      
        elsif input == "3"
            puts "Which venue?"
            display_list_of_venues
            id = gets.chomp
            find_events_by_venue(id) 
        elsif input == "4"
            puts "No problem! Your Favorites list 
            is the perfect way to keep track of the 
            dope events going down." 
            display_favorites(current_user)
        elsif input == "5" 
            puts "Alright then -- your loss! Thanks for using StubMaster though!"
            exit 
        elsif input == "exit" 
            exit 
        else 
            puts
            puts "I don't want to break the bad news,"
            puts "but we didn't understand what you typed." 
            puts "(Don't worry, we have stubby fingers too.)"
            puts
            puts "Why don't you try again?"
            puts
            main_menu
        end  
    return self.main_menu
    end
end

def display_to_user(event)
    puts 
    puts "Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts "Date: #{event.event_date}"
    puts
    would_you_like_to_favorite(event)
end

def display_price_comparison(event)
    puts
    puts "Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts "Date: #{event.event_date}"
    puts 
    flag = 0
    until flag == 1
  begin
    case
    when event.ticketmaster_price_min > event.seatgeek_price_min && event.ticketmaster_price_max > event.seatgeek_price_max
        puts "If you're looking for a more economical price for this event,"
        puts "StubMaster's patented Price Comparison App recommends buying tix from"
        puts "SeatGeek."
        puts 
        puts "If you're looking to ball out for this event but are the type to use coupons"
        puts "when you go food shopping, StubMaster's patented Price"
        puts "Comparison App recommends buying tix from SeatGeek."
        flag = 1
    when event.ticketmaster_price_min > event.seatgeek_price_min && event.ticketmaster_price_max < event.seatgeek_price_max
        puts "If you're looking for a more economical price for this event,"
        puts "StubMaster's patented Price Comparison App recommends buying tix from"
        puts "SeatGeek."
        puts
        puts "If you're looking to ball out for this event but are the type to use coupons"
        puts "when you go food shopping, StubMaster's patented Price"
        puts "Comparison App recommends buying tix from Ticketmaster."
        flag = 1
    when event.ticketmaster_price_min < event.seatgeek_price_min && event.ticketmaster_price_max < event.seatgeek_price_max
        puts "If you're looking for a more economical price for this event,"
        puts "StubMaster's patented Price Comparison App recommends buying tix from"
        puts "TicketMaster."
        puts
        puts "If you're looking to ball out for this event but are the type to use coupons"
        puts "when you go food shopping, StubMaster's patented Price"
        puts "Comparison App recommends buying tix from Ticketmaster."
        flag = 1
    when event.ticketmaster_price_min < event.seatgeek_price_min && event.ticketmaster_price_max > event.seatgeek_price_max
        puts "If you're looking for a more economical price for this event,"
        puts "StubMaster's patented Price Comparison App recommends buying tix from"
        puts "TicketMaster."
        puts
        puts "If you're looking to ball out for this event but are the type to use coupons"
        puts "when you go food shopping, StubMaster's patented Price"
        puts "Comparison App recommends buying tix from SeatGeek."
        flag = 1
    end
  rescue
    puts "You entered an incorrect value, please put in something else"
    id = gets.chomp
    event = find_event_by_id(id)
    display_price_comparison(event)
    flag = 0
  end
  end
    would_you_like_to_favorite(event)
end

def display_favorites(current_user)
    favs = find_favorites_by_user(current_user)
    favs.each_with_index do |fav, index|
        event_id = fav.event_id 
        event = Event.find(event_id) 
    puts 
    puts "#{index + 1}.Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts
    end
    puts "If you would like to remove a favorite please type Remove."
    puts "To return to the main menu select Main Menu"
    input = gets.chomp.downcase
     if input == "main menu"
        main_menu
     elsif  input == "remove"
        puts "Please input the number you would like to remove."
        input = gets.chomp
        delete_favorite(current_user, input)
     elsif input == "exit"
        exit
     else 
        main_menu
     end
end








            








