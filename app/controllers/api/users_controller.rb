class Api::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token
  
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      render json: {
        status: 'success',
        message: 'Đăng ký thành công!',
        user: {
          id: @user.id,
          first_name: @user.first_name,
          last_name: @user.last_name,
          email: @user.email,
          created_at: @user.created_at
        }
      }, status: :created
    else
      render json: {
        status: 'error',
        message: 'Có lỗi xảy ra khi đăng ký',
        errors: @user.errors.full_messages
      }, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
