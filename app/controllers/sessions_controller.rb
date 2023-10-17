class SessionsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]

  def new
  end

  def create
    admin = Admin.find_by(email: params[:session][:email].downcase)
    if admin && admin.authenticate(params[:session][:password])
      session[:admin_id] = admin.id
      flash[:notice] = 'ログインしました'
      redirect_to users_path
    else
      flash[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    session.delete(:admin_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path, turbolinks: false
  end
end