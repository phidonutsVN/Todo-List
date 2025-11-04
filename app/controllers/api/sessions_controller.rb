class Api::SessionsController < ApplicationController
  # Tắt CSRF protection cho API
  skip_before_action :verify_authenticity_token
  
  def create
    user = ::AuthService.login(
      email: params[:email],
      password: params[:password]
    )

    if user
      session[:user_id] = user.id
      render json: {
        status: 'success',
        message: 'Đăng nhập thành công!',
        user: {
          id: user.id,
          first_name: user.first_name,
          last_name: user.last_name,
          email: user.email
        }
      }
    else
      render json: {
        status: 'error',
        message: 'Email hoặc mật khẩu không đúng'
      }, status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    render json: {
      status: 'success',
      message: 'Đăng xuất thành công!'
    }
  end
end
