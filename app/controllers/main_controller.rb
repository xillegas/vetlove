class MainController < ApplicationController
  layout "main"

  def dashboard
    skip_authorization
    if current_user.is_vet?
      @bookings = Booking.joins(:consulting_room).where("consulting_room.user" => current_user.id)
      @next_consult = @bookings.find { |booking| !booking.attended? }      
      @consults_to_attend = @bookings.count { |booking| !booking.attended? }
    else
      @bookings = Booking.joins(:pet).where("pets.user" => current_user.id)
      @next_consult = @bookings.find { |booking| !booking.attended? }
      @consults_to_attend = @bookings.count { |booking| !booking.attended? }
    end
  end

  def configuration
    skip_authorization
  end
end
