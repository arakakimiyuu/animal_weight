class Public::PetsController < ApplicationController

  def new
    @pet = Pet.new
  end

  def index
    @pets = Pet.all.page(params[:page]).per(5)
  end

  def create
    @pet = Pet.find(pet_params)
    if @pet.save
      redirect_to pet_path
      flash[:notice] = "新規登録確認しました。"
    else
      render:new
    end
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def edit
    @pet = Pet.find(params[:id])
  end

  def update
    @pet = Pet.find(params[:id])
    if @pet.update(pet_params)
      redirect_to pet_path
      flash[:notice] = "変更を保存しました。"
    else
      render:edit
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_path
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name, :pet_type, :pet_kind, :gender, :color, :personality)
  end
end
