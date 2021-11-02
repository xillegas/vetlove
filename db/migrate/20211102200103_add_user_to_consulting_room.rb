class AddUserToConsultingRoom < ActiveRecord::Migration[6.1]
  def change
    add_reference :consulting_rooms, :user, null: false, foreign_key: true
  end
end
