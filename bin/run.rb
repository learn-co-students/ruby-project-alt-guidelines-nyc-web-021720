require_relative '../config/environment'

require_relative '../config/environment'

cli = CommandLineInterface.new 
cli.welcome 

prompt = TTY::Prompt.new 


prompt.ask('What is your name?')
prompt.yes?('Do you like Ruby?')
prompt.mask("Enter your password")
prompt.select("Choose your destiny", %w(Scorpion Kano Jax))
choices=%w(Vodka Beer Wine Whisky Bourbon)
prompt.multi_select("Select drinks?", choices)
choices_two=%w(EMACS Nano Vim)
prompt.enum_select("Select an editor?", choices_two)
choices_three = [
  { key: 'y', name: 'overwrite this file', value: :yes },
  { key: 'n', name: 'do not overwrite this file', value: :no },
  { key: 'a', name: 'overwrite this file and all later files', value: :all },
  { key: 'd', name: 'show diff', value: :diff },
  { key: 'q', name: 'quit; do not overwrite this file ', value: :quit }
]
prompt.expand('Overwrite Gemfile?', choices_three)


result = prompt.collect do
  key(:name).ask('Name?')
  key(:age).ask('Age?', convert: :int)
  key(:address) do
  key(:street).ask('Street?', required: true)
  key(:city).ask('City?')
  key(:zip).ask('Zip?', validate: /\A\d{3}\Z/)
  end
end
