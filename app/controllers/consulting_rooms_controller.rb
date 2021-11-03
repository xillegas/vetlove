class ConsultingRoomsController < ApplicationController
    before_action :authenticate_user!, except: [:index]
    before_action :authorize_pundit, except: [:index]

  def index
    skip_policy_scope
    @user = current_user
    @consulting_rooms = ConsultingRoom.all
  end

  def new
    @user = current_user
    @consulting_room = ConsultingRoom.new
  end

  def create
    @consulting_room = ConsultingRoom.new(params_consulting_rooms)
    @user = current_user
    @consulting_room.user = @user
    @consulting_room.save
    redirect_to consulting_rooms_path, notice: 'Consultorio creado exitosamente!'
  end

  def edit
    @user = current_user
    @consulting_room = ConsultingRoom.find(params[:id])
  end

  def update
    @consulting_room = ConsultingRoom.find(params[:id])
    @user = current_user
    @consulting_room.update(params_consulting_rooms)
    redirect_to consulting_rooms_path, notice: 'Datos del consultorio actualizados exitosamente!'
  end

  def destroy
    @consulting_room = ConsultingRoom.find(params[:id])
    @consulting_room.destroy
    redirect_to consulting_rooms_path, notice: 'Consultorio eliminado exitosamente!'
  end

  private

  def params_consulting_rooms
    params.require(:consulting_room).permit(:name, :address, :description, :state, :municipality, :parish, :init_hour_day, :end_hour_day, :week_days, :user_id)
  end

  def authorize_pundit
    @consulting = policy_scope(ConsultingRoom)
    authorize @consulting
  end
end
