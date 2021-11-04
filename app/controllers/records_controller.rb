class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:show]
  before_action :authenticate_pundit

  def index
    @records = Record.all
  end

  def show
  end

  def new
    @record = Record.new
  end

  def create
    @record = Record.new(record_params)
  end

  private

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
