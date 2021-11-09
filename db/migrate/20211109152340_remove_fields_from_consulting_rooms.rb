class RemoveFieldsFromConsultingRooms < ActiveRecord::Migration[6.1]
  def change
    remove_column :consulting_rooms, :state, :string
    remove_column :consulting_rooms, :municipality, :string
    remove_column :consulting_rooms, :parish, :string
  end
end
