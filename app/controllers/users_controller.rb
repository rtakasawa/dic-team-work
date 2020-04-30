class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  before_action :login_check_user

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(user_params)
  	if @user.save
      session[:user_id] = @user.id
      redirect_to blogs_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  	if @user.update(user_params)
			redirect_to user_path(@user.id), flash: { notice: "プロフィールを編集しました" }
		else
			render :edit
		end
  end

  def destroy
    @user = current_user
    @user.destroy
    redirect_to new_user_path, flash: { notice: "ユーザーを削除しました" }
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end

  def login_check_user
    unless logged_in?
      redirect_to root_path
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

end
