cli = CommandLineInterface.new 
cli.main_menu

class CLI 

    def main_menu    
        puts "Stubmaster Main Menu"
        puts "*-----------------------*"
        puts "1. Find events in NYC by artist" #R
        puts "2. Find events in NYC by venue" #R
        puts "3. Stubmaster Price Comparison App TM"
        puts "4. Check your favorites" #R
        
        input = gets.chomp
        if input == 1
            puts "Which artist?"
            artist = gets.chomp
            find_nyc_events_by_artist(artist)
        elsif input == 2 
            puts "Which venue?"
            venue = gets.chomp 
            find_nyc_events_by_venue(venue)
        elsif input == 3
            puts "Nice! This is what we're all about, 
            after all. What event were you thinking about?"
            price_comparison
        elsif input == 4
            puts "No problem! Your Favorites list 
            is the perfect way to keep track of the 
            dope events going down." 
            return favorites_list
        elsif input == 5 
            exit 
        else "I don't want to break the bad news,
            but we didn't understand what you typed. 
            Don't worry, we have stubby fingers too.  
            Want to try again?"
            gets.chomp
        end    
    return self.main_menu
end





            








