class Public::PetsController < ApplicationController
  
  def new
  end

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name, :pet_type, :pet_kind, :gender, :color, :personality)
  end
end
