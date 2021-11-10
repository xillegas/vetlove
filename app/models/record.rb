class Record < ApplicationRecord
  belongs_to :booking

  after_create_commit :update_booking_record

  private

  def update_booking_record
    booking = self.booking
    booking.update(attended: true, date: DateTime.now)
  end
end
