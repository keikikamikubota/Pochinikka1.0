class AdminsController < ApplicationController
  skip_before_action :login_required, only: [:new, :create]
  def new
    @admin = Admin.new
  end

  def show
    @admin = Admin.find(params[:id])
    binding.pry
    if @admin.id != current_user.id
      flash[:alert] =  "本人以外のユーザー閲覧はできません"
      redirect_to users_path
    end
  end

  def edit
    @admin = Admin.find(params[:id])
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      session[:admin_id] = @admin.id
      flash[:success] = "登録が完了しました。"
      redirect_to admin_path(@admin.id)
    else
      render :new
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
