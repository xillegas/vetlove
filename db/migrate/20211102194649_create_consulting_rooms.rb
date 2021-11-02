class CreateConsultingRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :consulting_rooms do |t|
      t.string :name
      t.string :address
      t.string :description
      t.string :state
      t.string :municipality
      t.string :parish
      t.float :lat
      t.float :lon
      t.time :init_hour_day
      t.time :end_hour_day
      t.string :week_days

      t.timestamps
    end
  end
end
