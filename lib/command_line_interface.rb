require_relative '../lib/game.rb'
require_relative '../lib/team.rb'

class CommandLineInterface

  attr_accessor :favorite_team

  def welcome 
    puts "Welcome to League Manager!\n "
  end


  #this method will give user an option to pick their home and away team
  def create_game
    puts "Pick your home team"
    home_team = gets.chomp.capitalize.strip 

    puts "Pick your away team"
    away_team = gets.chomp.capitalize.strip  
    

    home_team_id = Team.where('name LIKE ?', '%' + "#{home_team}" + '%').ids.pop
    away_team_id = Team.where('name LIKE ?', '%' + "#{away_team}" + '%').ids.pop 

    db_home_team = Team.where('name LIKE ?', '%' + "#{home_team}" + '%').pluck(:name).pop 
    db_away_team = Team.where('name LIKE ?', '%' + "#{away_team}" + '%').pluck(:name).pop 

   
    game = Game.create(home_team_id: home_team_id, away_team_id: away_team_id)

    puts "Great! You scheduled the #{db_home_team} to play against the #{db_away_team}!"
  end

  
  def end_app
    puts "Thanks for using League Manager\n"
  end


  def team_stadium_name(team)
    puts Team.where('name LIKE ?', '%' + "#{team}" + '%').pluck(:stadium_name).pop
  end


  def team_stadium_location(team)
    puts Team.where('name LIKE ?', '%' + "#{team}" + '%').pluck(:stadium_location).pop
  end


  def show_games
    Game.all.map do |game|
      puts "\tGame #{game.id} - the #{Team.find_by(id: game.home_team_id).name} vs the #{Team.find_by(id: game.away_team_id).name}"
    end
  end


  def home_games(fav_team_object)
    list = fav_team_object.pop
    home_games = list.home_games
    name = list.name

    
    if home_games.length < 1
      puts "\tThe #{name} have not played as the home team yet"
    end
    
   
    home_games.each do |game|
     puts "\tIn game #{game.id} - the #{Team.find_by(id: game.home_team_id).name} played against the #{Team.find_by(id: game.away_team_id).name} at the #{Team.find_by(id: game.home_team_id).stadium_name}"
    end
  end


  def away_games(fav_team_object)
    list = fav_team_object.pop
    away_games = list.away_games
    name = list.name 

    if away_games.length < 1
      puts "\tThe #{name} have not played as the away team yet"
    end
    
    
    away_games.each do |game|
     puts "\tIn game #{game.id} - the #{Team.find_by(id: game.away_team_id).name} played against the #{Team.find_by(id: game.home_team_id).name} at the #{Team.find_by(id: game.home_team_id).stadium_name}"
    end
  end



  def get_results
    last_game = Game.last
    home_team_id = Game.last.home_team_id
    away_team_id = Game.last.away_team_id

    home_score = rand(90..125)
    away_score = rand(90..125)

    puts "Final score: the #{Team.find_by(id: home_team_id).name} #{home_score} - the #{Team.find_by(id: away_team_id).name} #{away_score}"
    if home_score < away_score 
      puts "The #{Team.find_by(id: away_team_id).name} won the game!"
    else 
      puts "The #{Team.find_by(id: home_team_id).name} won the game!"
    end
  end
 
end  


