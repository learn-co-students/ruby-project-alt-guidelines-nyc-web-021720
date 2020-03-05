require_relative '../config/environment.rb'

class CLI 

    def initialize
        puts 
        puts 
        puts "Welcome to StubMaster, home of the immediate-friend-group-famous"
        puts "Stubmaster Price Comparison app. Compare prices and find out about"
        puts "all the most fire events all throughout the Big Apple!"
        puts
    end

    def main_menu    
        puts
        puts "StubMaster Main Menu"
        puts "*-----------------------*"
        puts "1. StubMaster Price Comparison App TM" #R
        puts "2. Find events in NYC by artist" #R
        puts "3. Find events in NYC by venue"
        puts "4. Check your favorites" #R
        puts "5. Aight, I'mma head out."
        puts 
        input = STDIN.gets.chomp.downcase
        if input == "1"
            puts "Nice! This is what we're all about, 
            after all. Which event were you thinking about?"
            price_comparison            
        elsif input == "2" 
            puts "Which artist?"
            artist = STDIN.gets.chomp
            find_nyc_events_by_artist(artist)
        elsif input == "3"
            puts "Which venue?"
            venue = STDIN.gets.chomp 
            find_nyc_events_by_venue(venue)
        elsif input == "4"
            puts "No problem! Your Favorites list 
            is the perfect way to keep track of the 
            dope events going down." 
            return favorites_list
        elsif input == "5" 
            exit 
        else 
            puts "I don't want to break the bad news,
            but we didn't understand what you typed. 
            (Don't worry, we have stubby fingers too.)"
            puts
            puts "Want to try again?"
            STDIN.gets.chomp
        end    
    return self.main_menu
    end
end

def display_to_user(event)
    puts
    puts
    puts "Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts
    puts
end

def display_price_comparison(event)
    puts
    puts
    puts "Artist Name: #{event.artist_name}"
    puts "Venue: #{event.venue_name}"
    puts ""
    puts
end







            








