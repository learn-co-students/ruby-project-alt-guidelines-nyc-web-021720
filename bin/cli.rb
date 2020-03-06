require_relative '../config/environment'

class CLI 

    attr_accessor :current_user, :event

    def initialize(current_user = nil)
        puts 
        puts "Welcome to StubMaster, home of the immediate-friend-group-famous"
        puts "Stubmaster Price Comparison app. Compare prices and find out about"
        puts "all the most fire events all throughout the Big Apple!"
        puts
    end
    
    def log_in
        flag = 0
        until flag == 1
        puts "Please enter your username."
        puts "Press 1 to create a username."
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
        first_name = gets.chomp
        puts "Please enter your last name:"
        last_name = gets.chomp
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
            artist = STDIN.gets.chomp
            find_events_by_artist(artist)
        elsif input == "3"
            puts "Which venue?"
            venue = STDIN.gets.chomp 
            find_events_by_venue(venue)
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
            next_option
        end  
    return self.main_menu
    end
end

def display_to_user(event)
    puts
    puts "Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts
    puts
end

def display_favorites(current_user)
    favs = find_favorites_by_user(current_user)
    favs.each_with_index do |fav, index|
        event_id = fav.event_id 
        event = Event.find(event_id) 
    puts
    puts "Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts
    end
end


def find_favorites_by_user(current_user)
    userobj = User.find_by username: current_user 
    Favorite.select do |favorites|
        favorites.user_id == userobj.id
    end
end





            








