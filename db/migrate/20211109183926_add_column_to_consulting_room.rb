class AddColumnToConsultingRoom < ActiveRecord::Migration[6.1]
  def change
    add_column :consulting_rooms, :specific_address, :string
  end
end
