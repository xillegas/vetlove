class AddAttendedToBookings < ActiveRecord::Migration[6.1]
  def change
    add_column :bookings, :attended, :boolean, default: false
  end
end
