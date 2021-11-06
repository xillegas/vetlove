class AddAnimalToConsultingRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :consulting_rooms, :animal, :string
  end
end
