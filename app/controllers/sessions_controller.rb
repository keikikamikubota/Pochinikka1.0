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
      flash.now[:danger] = 'ログインに失敗しました'
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("flash_messages", partial: "shared/flash_messages", locals: { flash: flash })
        end
        format.html { render :new }
      end
    end
  end

  def destroy
    session.delete(:admin_id)
    flash[:notice] = 'ログアウトしました'
    redirect_to new_session_path, turbolinks: false
  end
end