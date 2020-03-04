require_relative '../config/environment.rb'

page = 0
nyresults = []

until page == 5
    resp = RestClient.get("https://app.ticketmaster.com/discovery/v2/events.json?countryCode=US&stateCode=NY&classificationName=music&size=200&source=ticketmaster&sort=date,asc&page=#{page}&apikey=wid6UhVnt7EDAmE2zohmjVgs6Cw4pCpy")
    tmresults = JSON.parse(resp)
    nyresults << tmresults
    page += 1
end

File.open("tmresults.txt", "w") do |file|
    file.write nyresults
end

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




