class BookingsController < ApplicationController
  def index
    @bookings = Booking.joins(:pet).where("pets.user" => current_user.id)
    # @user = current_user
    # @bookings = Booking.all
    # @user_bookings = []
    # @bookings.each do |booking|
    #   if booking.pet.user_id == @user.id
    #     @user_bookings << booking
    #   end
    # end
    # @user_bookings
  end

  def show
    @booking = Booking.find(params[:id])
  end

  def new
    @booking = Booking.new
    @consulting_room = ConsultingRoom.find(params[:consulting_room_id])
    @my_pets = Pet.joins(:user).where(id: current_user.id)
  end

  def create
    @user = current_user
    @consulting_room = ConsultingRoom.find(params[:consulting_room_id])
    @booking = Booking.new(booking_params)
    @booking.user = @user
    @booking.consulting_room = @consulting_room
    #authorize @booking
    if @booking.save
      redirect_to bookings_path, notice: 'Booking creado exitosamente.'
    else
      redirect_to bookings_path, alert: 'Wrong parmeters'
    end
  end

  def calendar
     @bookings = Booking.joins(:consulting_room).where("consulting_room.user" => current_user.id)
  end

  private

  def booking_params
    params.require(:booking).permit(:date, :time, :pet_id)
  end
end
