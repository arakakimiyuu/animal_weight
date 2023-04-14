class Public::PetsController < ApplicationController
  #編集,更新,削除を別の会員がいじらないようにするための記述
  before_action :ensure_current_customer, only: [:edit, :update, :destroy]
  #ゲストユーザーでログインできても一覧、詳細は見れても登録、作成、更新、削除はできない
  before_action :reject_guest_customer, only: [:new, :create, :edit, :update, :destroy]

  def new
    @pet = Pet.new
  end

  def index
    @pets = Pet.all.page(params[:page]).per(10)

     #ビューからの指示を受けるための名前を定義
    if params[:latest]
     @pets = Pet.latest
    elsif params[:old]
     @pets = Pet.old
    else
     @pets = Pet.all
    end

  end

  def create
    @pet = Pet.new(pet_params)
    @pet.customer_id = current_customer.id
    if @pet.save
      redirect_to pet_path(@pet)
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
      redirect_to pet_path(@pet.id)
      flash[:notice] = "変更を保存しました。"
    else
      render:edit
    end
  end

  def destroy
    @pet = Pet.find(params[:id])
    @pet.destroy
    redirect_to pets_path
    flash[:notice] = "削除に成功しました。"
  end

  #投稿者 = 現在ログインしている会員でない場合
  def ensure_current_customer
     @pet = Pet.find(params[:id])
     unless @pet.customer == current_customer
      redirect_to pet_path(@pet)
     end
  end

  private

  def pet_params
    params.require(:pet).permit(:pet_name, :pet_type, :pet_kind, :birth_date, :gender, :color, :personality, :customer_id, :image)
  end

end
