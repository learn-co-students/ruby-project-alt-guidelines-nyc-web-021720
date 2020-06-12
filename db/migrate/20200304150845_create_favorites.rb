class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
        create_table :favorites do |t|
        t.string :username
        t.string :event_name
        t.integer :user_id
        t.integer :event_id
        end
  end
end
