class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :artist_name
      t.string :venue_name
      t.date :event_date
      t.float :ticketmaster_price
      t.float :seatgeek_price
      t.float :price_difference
      t.integer :artist_id
      t.integer :venue_id
      end
  end
end
