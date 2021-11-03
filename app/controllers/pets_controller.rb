class PetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:create, :edit, :update]
  before_action :set_pet, only: [ :show, :edit, :update, :destroy ]

  def index
    @pets = Pet.all
  end

  def show
  end

  def new
    @pet = Pet.new
  end

  def create
    @pet = Pet.new(pet_params)
    @pet.user = @user
    if @pet.save
      redirect_to pets_path, notice: 'Mascota creado exitosamente.'
    else
      redirect_to pet_path(@pet), alert: 'Wrong parmeters'
    end
  end

  def edit
  end

  def update
    if @pet.update(pet_params)
      redirect_to @pet, notice: 'Pet was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    if @pet.destroy
      redirect_to pets_path, notice: 'Pet was successfully destroyed.'
    else
      render 'pets'
    end
  end

  private

  def set_pet
     @pet = Pet.find(params[:id])
  end

  def pet_params
    params.require(:pet).permit(:name, :gender, :birthdate, :species, :user_id)
  end

  def set_user
    if user_signed_in?
      @user = current_user
    else
      redirect_to new_user_session_path
    end
  end
end
