class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:show]
  before_action :authenticate_pundit
  before_action :get_booking, except: [:index, :show]
  layout 'main', only: %i[index show new]


  def index
    @records = Record.all
    @user_record = []
    @records.each do |record|
      if current_user.is_vet?
        if record.booking.consulting_room.user == current_user
          @user_record << record
        end
      else
        if record.booking.pet.user == current_user
          @user_record << record          
        end 
      end
    end
  end

  def show
    @record = Record.find(params[:id])
    if @record.booking.pet.user == current_user || @record.booking.consulting_room.user == current_user
      return @record
    else
      flash[:notice] = "Your record was not found"
      redirect_to booking_records_path(@record)
    end
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
    @record.booking = @booking
    if @record.save
      redirect_to records_path, notice: 'Record creado exitosamente.'
    else
      render :new, alert: 'Wrong parmeters'
    end
  end

  private

  def get_booking
    @booking = Booking.find(params[:booking_id])
  end

  def record_params
    params.require(:record).permit(:booking_id, :symptoms, :diagnostic, :treatment)
  end

  def set_record
    @record = Record.find(params[:id])
  end

  def authenticate_pundit
    @record = policy_scope(Record)
    authorize @record
  end
end
