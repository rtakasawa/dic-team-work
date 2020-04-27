class UsersController < ApplicationController

  before_action :login_check_user
  # , only: [:new,:create,:show,:edit,:update]

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
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
  	if @user.update(user_params)
			redirect_to user_path(@user.id), notice: "編集しました！"
		else
			render :edit
		end
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
end
