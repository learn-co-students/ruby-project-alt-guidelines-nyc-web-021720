require_relative '../config/environment'
require_relative '../reference/tmresults'
require 'pry'
require 'rest-client'
require 'json'

=begin
#page = 0
#nyresults = []
#until page == 5
 resp = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?country
  #  nyresults << tmresults
  #  page += 1
#end
=end

=begin the below code writes the results to a new file
File.open("tmresults.txt", "w") do |file|
    file.write nyresults
end
=end

resp = RestClient.get("https://api.seatgeek.com/2/events?format=json&taxonomies.id=2000000&postal_code=10014&range=35mi&page=1&c
sgresults = JSON.parse(resp)
File.open("./reference/sgresults.rb", "w") do |file|
    file.write sgresults
end
