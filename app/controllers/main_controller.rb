class MainController < ApplicationController
  layout "main"

  def dashboard
    skip_authorization
    if current_user.is_vet?
      @bookings = Booking.joins(:consulting_room).where("consulting_room.user" => current_user.id)
    else
      @bookings = Booking.joins(:pet).where("pets.user" => current_user.id)
    end
  end

  def configuration
    skip_authorization
  end
end
