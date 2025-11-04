class UsersController < ApplicationController
  before_action :require_login, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :destroy]
  def index
    if logged_in?
      @user = current_user
      @tasks = @user.tasks.includes(:category, :tags)
      @categories = @user.categories
    else
      redirect_to login_path
    end
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Đăng ký thành công! Chào mừng bạn đến với Todo List!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params_update)
      redirect_to @user, notice: "User updated successfully"
    else
      render :edit
    end
  end

  def destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def authorize_user!
    redirect_to root_path, alert: "Not authorized" unless @user == current_user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def user_params_update
    params.require(:user).permit(:first_name, :last_name, :email)
  end
end
