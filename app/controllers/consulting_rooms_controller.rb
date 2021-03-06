class ConsultingRoomsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :authorize_pundit, except: [:index]
  before_action :set_user_ip, only: [:index_user, :index_vet, :index]
  layout "main", only: %i[new index_vet index_user edit]
  DEFAULT_DAYS = ["Lunes", "Martes", "Miercoles", "Jueves", "Viernes"]
  DEFAULT_LON_LAT = [-66.8762112, 10.4923136]
  DEFAULT_ANIMAL = ["Perro", "Gato", "Tortuga", "Conejo", "Hamster", "Ave", "Capibara", "Serpiente", "Cerdo", "Caballo"]

  def index_vet
    @user = current_user
    @consulting_rooms = ConsultingRoom.all.order(id: :desc)
    @query_rooms = []
    @consulting_rooms.each do |room|
      @query_rooms << room if room.user == @user
    end
  end

  def index_user
    @user = current_user
    @consulting_rooms = ConsultingRoom.all
    # binding.pry
    @query_rooms = []
    if params[:query].present?
      @query_rooms = ConsultingRoom.search_by_name(params[:query]).order(id: :desc)
      search(@query_rooms)
    else
      @query_rooms = ConsultingRoom.order(id: :desc).take(50)
      search(@query_rooms)
    end
  end

  def index
    skip_policy_scope
    @consulting_rooms = ConsultingRoom.all
    @user = current_user
    @query_rooms = []
    if user_signed_in?
      if @user.is_vet
        redirect_to consulting_rooms_vet_path, notice: "Vets Index"
      else
        redirect_to consulting_rooms_user_path, notice: "Users Index"
      end
    else
      if params[:query].present?
        @query_rooms = ConsultingRoom.search_by_name(params[:query]).order(id: :desc)
        search(@query_rooms)
      else
        @query_rooms = ConsultingRoom.order(id: :desc).take(50)
        search(@query_rooms)
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
    selected_days = params[:selected_days]
    selected_keywords = selected_keywords.nil? ? DEFAULT_ANIMAL : selected_keywords
    selected_days = selected_days.nil? ? DEFAULT_DAYS : selected_days
    @user = current_user
    @consulting_room.user = @user
    @consulting_room.animal = selected_keywords.join(", ")
    @consulting_room.week_days = selected_days.join(", ")
    @consulting_room.latitude = DEFAULT_LON_LAT[1] unless params_consulting_rooms[:latitude].present?
    @consulting_room.longitude = DEFAULT_LON_LAT[0] unless params_consulting_rooms[:longitude].present?
    if @consulting_room.save
      redirect_to consulting_rooms_path, notice: "Consultorio creado exitosamente!"
    else
      render :new, layout: "main"
    end
  end

  def edit
    @user = current_user
    @consulting_room = ConsultingRoom.find(params[:id])
  end

  def update
    @consulting_room = ConsultingRoom.find(params[:id])
    @user = current_user
    selected_days = params[:selected_days]
    selected_keywords = params[:selected_keywords]
    selected_keywords = selected_keywords.nil? ? DEFAULT_ANIMAL : selected_keywords
    selected_days = selected_days.nil? ? DEFAULT_DAYS : selected_days
    @consulting_room.animal = selected_keywords.join(", ")
    @consulting_room.week_days = selected_days.join(", ")
    @consulting_room.update(params_consulting_rooms)
    redirect_to consulting_rooms_path, notice: "Datos del consultorio actualizados exitosamente!"
  end

  def destroy
    @consulting_room = ConsultingRoom.find(params[:id])
    @consulting_room.destroy
    redirect_to consulting_rooms_path, notice: "Consultorio eliminado exitosamente!"
  end

  private

  def set_user_ip
    @client_ip = remote_ip()
    # binding.pry
    @user_marker = Geocoder::search(@client_ip)
    # p @user_marker.first.data["ip_address"]
    if @user_marker.length > 0
      @info_window_user =
        {
          user_ip: @user_marker.first.data["ip_address"],
          lat: @user_marker.first.data["latitude"],
          lng: @user_marker.first.data["longitude"],
          city: @user_marker.first.data["city"],
          :info_window => render_to_string(partial: "info_window_user", locals: { marker: @user_marker }),
        }
    else
      # Rellenar
      @info_window_user =
      {
        user_ip: ENV["DEFAULT_IP"],
        lat: 10.4923136,
        lng: -66.8762112,
        city: "Chacao, Avenida Francisco de Miranda, Caracas 1060, Distrito Capital",
        info_window: "info_window"
      }
    end
    return @info_window_user
  end

  def search(query_rooms)
    @markers = []
    query_rooms.each do |consulting_room|
      @markers << { lat: consulting_room.latitude,
                    lng: consulting_room.longitude,
                    info_window: render_to_string(partial: "info_window", locals: { consulting_room: consulting_room }) }
    end
  end

  def params_consulting_rooms
    params.require(:consulting_room).permit(:name, :specific_address, :address, :longitude, :latitude, :description, :init_hour_day, :end_hour_day, :week_days, :user_id)
  end

  def authorize_pundit
    @consulting = policy_scope(ConsultingRoom)
    authorize @consulting
  end
end
