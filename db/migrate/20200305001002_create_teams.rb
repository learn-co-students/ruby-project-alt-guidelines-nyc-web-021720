class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.string :name
      t.string :stadium_name
      t.string :stadium_location
    end
  end
end
