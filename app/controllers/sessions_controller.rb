class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = ::AuthService.login(
      email: params[:email],
      password: params[:password]
    )

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Đăng nhập thành công!"
    else
      flash.now[:alert] = "Email hoặc mật khẩu không đúng"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Đăng xuất thành công!"
  end
end
