
require 'pry'
require 'rest-client'
require 'json'
 resp = 

file = File.read('reference/sgjson.json')
$globsgdata = JSON.parse(file)

