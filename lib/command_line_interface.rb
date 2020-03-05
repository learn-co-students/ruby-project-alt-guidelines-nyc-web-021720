require_relative '../lib/game.rb'
require_relative '../lib/team.rb'

class CommandLineInterface

  def welcome 
    puts "Welcome League Manager! Let's schedule an NBA game!"
  end

  #this method will give user an option to pick their home and away team
  def create_game
    puts "Pick your home team"
    home_team = gets.chomp.capitalize 

    puts "Pick your away team"
    away_team = gets.chomp.capitalize 
    

    home_team_id = Team.where('name LIKE ?', '%' + "#{home_team}" + '%').ids.pop
    away_team_id = Team.where('name LIKE ?', '%' + "#{away_team}" + '%').ids.pop 

    db_home_team = Team.where('name LIKE ?', '%' + "#{home_team}" + '%').pluck(:name).pop 
    db_away_team = Team.where('name LIKE ?', '%' + "#{away_team}" + '%').pluck(:name).pop 

   
    game = Game.create(home_team_id: home_team_id, away_team_id: away_team_id)

    puts "Great! You scheduled the #{db_home_team} to play against the #{db_away_team}!"
    
  end

end  


