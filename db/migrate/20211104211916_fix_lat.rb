class FixLat < ActiveRecord::Migration[6.1]
  def change
    rename_column :consulting_rooms, :lat, :latitude
    rename_column :consulting_rooms, :lon, :longitude
  end
end
