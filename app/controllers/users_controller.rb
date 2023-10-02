class UsersController < ApplicationController
  def index
    @users = Users.all
  end



  def show
    @user = User.find(params[:id])
  end

  # def new
  #   @user = User.new
  # end

  def edit
    #管理者ユーザーでない場合ログイン画面に遷移
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user.params)
      redirect_to user_path, notice: "ユーザー情報を更新しました"
    else
      render :edit
  end

  def destroy
    @user = User.find(params[:id])
    @user.destory
    redirect_to users_path
  end

  private
  def user_params
    params.require(:user).permit(%i[name email phone  note admin_note] )
  end
end