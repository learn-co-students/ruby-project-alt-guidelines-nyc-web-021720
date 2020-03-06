require_relative '../config/environment'

cli = CommandLineInterface.new
prompt = TTY::Prompt.new 


# puts welcome message 
cli.welcome

# collectes favorite team from prompt question 
fav_team = prompt.ask("What’s your favorite NBA team?".capitalize)


choices = %w(Yes No)
stadium_name = prompt.multi_select("Do you want to know your favorite teams stadium name?", choices, active_color: :red)
if stadium_name.pop == choices[0]
  cli.team_stadium_name(fav_team)
else
  puts "Okay!"
end
 

location = prompt.multi_select("Do you want to know your favorite teams stadium location?", choices, active_color: :red)
if location.pop == choices[0]
  cli.team_stadium_location(fav_team)
else
  puts "Okay!" 
end


create_game_question = prompt.multi_select("Do you want to create an NBA game?", choices, active_color: :red)
if create_game_question.pop == choices[0]
  cli.create_game
  game_results = prompt.multi_select("Do you want to know the score?", choices, active_color: :red)
  if game_results.pop == choices[0]
    cli.get_results
  end
else
  cli.end_app 
end


show_games_question = prompt.multi_select("Do you want to see all the played games", choices, active_color: :red)
if show_games_question.pop == choices[0]
  puts "Here are all the played games!"
  cli.show_games
else
  puts "Okay!"
end


favorite_team_games = prompt.multi_select("Do you want to see all the games where your favorite team played at home?", choices, active_color: :red)
if favorite_team_games.pop == choices[0]
  fav_team_object = Team.all.select do |team|
    team.name == Team.where('name LIKE ?', '%' + "#{fav_team}" + '%').pluck(:name).pop
  end
  puts "Here are the #{Team.where('name LIKE ?', '%' + "#{fav_team}" + '%').pluck(:name).pop} home games:"
  cli.home_games(fav_team_object)
else
  puts "Okay moving forward!"
end


favorite_team_games_away = prompt.multi_select("Do you want to see all the games where your favorite team played away?", choices, active_color: :red)
if favorite_team_games_away.pop == choices[0]
  fav_team_object = Team.all.select do |team|
    team.name == Team.where('name LIKE ?', '%' + "#{fav_team}" + '%').pluck(:name).pop
  end
  puts "Here are the #{Team.where('name LIKE ?', '%' + "#{fav_team}" + '%').pluck(:name).pop} away games:"
  cli.away_games(fav_team_object)
else
  puts "Okay!"
end





