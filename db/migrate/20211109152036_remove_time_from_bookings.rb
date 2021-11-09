class RemoveTimeFromBookings < ActiveRecord::Migration[6.1]
  def change
    remove_column :bookings, :time, :time
  end
end
