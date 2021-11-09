class ConsultingRoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authorize_pundit, except: [:index]
  layout "main", only: %i[new index_vet index_user edit]

  def index_vet
    @user = current_user
    @consulting_rooms = ConsultingRoom.all
    @query_rooms = []
    @consulting_rooms.each do |room|
      @query_rooms << room if room.user == @user
    end
  end

  def index_user
    @user = current_user
    @consulting_rooms = ConsultingRoom.all
    @query_rooms = []
    @client_ip = remote_ip()
    if params[:query].present?
      @query_rooms = ConsultingRoom.search_by_name(params[:query])
      search(@query_rooms)
    else
      @query_rooms = ConsultingRoom.take(7)
    end
    @markers = @consulting_rooms.geocoded.map do |consulting_room|
      {
        lat: consulting_room.latitude,
        lng: consulting_room.longitude,
        info_window: render_to_string(partial: "info_window", locals: { consulting_room: consulting_room }),
      }
    end
    @user_marker = Geocoder::search(@client_ip)
    @user_marker.each do |marker|
      @info_window_user = {lat: marker.latitude,
                          lng: marker.longitude,
                          :info_window => render_to_string(partial: "info_window_user", locals: { marker: marker })}
    end
  end

  def index
    skip_policy_scope
    @consulting_rooms = ConsultingRoom.all
    @user = current_user
    @query_rooms = []
    @client_ip = remote_ip()
    if user_signed_in?
      if @user.is_vet
        redirect_to consulting_rooms_vet_path, notice: "Vets Index"
      else
        redirect_to consulting_rooms_user_path, notice: "Users Index"
      end
    else
      if params[:query].present?
        @query_rooms = ConsultingRoom.search_by_name(params[:query])
        search(@query_rooms)
      else
        @query_rooms = ConsultingRoom.take(6)
      end
      @markers = @consulting_rooms.geocoded.map do |consulting_room|
        {
          lat: consulting_room.latitude,
          lng: consulting_room.longitude,
          info_window: render_to_string(partial: "info_window", locals: { consulting_room: consulting_room }),
        }
      end
      @user_marker = Geocoder::search(@client_ip)
      @user_marker.each do |marker|
        @info_window_user = {lat: marker.latitude,
                            lng: marker.longitude,
                            :info_window => render_to_string(partial: "info_window_user", locals: { marker: marker })}
      end
    end
  end

  def new
    @user = current_user
    @consulting_room = ConsultingRoom.new
  end

  def create
    @consulting_room = ConsultingRoom.new(params_consulting_rooms)
    # Selected keywords es el nombre del formulario
    selected_keywords = params[:selected_keywords]
    @user = current_user
    @consulting_room.user = @user
    @consulting_room.animal = selected_keywords.join(" ")
    @consulting_room.save
    redirect_to consulting_rooms_path, notice: "Consultorio creado exitosamente!"
  end

  def edit
    @user = current_user
    @consulting_room = ConsultingRoom.find(params[:id])
  end

  def update
    @consulting_room = ConsultingRoom.find(params[:id])
    @user = current_user
    @consulting_room.update(params_consulting_rooms)
    redirect_to consulting_rooms_path, notice: "Datos del consultorio actualizados exitosamente!"
  end

  def destroy
    @consulting_room = ConsultingRoom.find(params[:id])
    @consulting_room.destroy
    redirect_to consulting_rooms_path, notice: "Consultorio eliminado exitosamente!"
  end

  private

  def search(query_rooms)
    @markers = query_rooms.geocoded.map do |consulting_room|
      {
        lat: consulting_room.latitude,
        lng: consulting_room.longitude,
        info_window: render_to_string(partial: "info_window", locals: { consulting_room: consulting_room }),
      }
    end
  end

  def params_consulting_rooms
    params.require(:consulting_room).permit(:name, :address, :description, :init_hour_day, :end_hour_day, :week_days, :user_id)
  end

  def authorize_pundit
    @consulting = policy_scope(ConsultingRoom)
    authorize @consulting
  end
end
