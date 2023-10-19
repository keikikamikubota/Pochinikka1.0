class UsersController < ApplicationController
  before_action :search, only: [:index]

  def index
    @users = @q.result(distinct: true).page(params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "顧客を新規作成しました。"
      redirect_to user_path(@user.id)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = '顧客の編集が完了しました!'
      redirect_to user_path
    else
      # render時にJSを追加するための処理
      @update_failed = true
      render :edit
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path
  end

  # エクスポートを実行するメソッド
  def export_to_google_sheets
    spreadsheet_id = params[:spreadsheet_id]
    range = params[:range]
    if ExportUsersService.new(spreadsheet_id, range).call
      flash[:notice] = 'エクスポートが完了しました!'
    else
      flash[:alert] = 'エクスポートに失敗しました。'
    end
    redirect_to users_path
  end

  private

  # ransack検索用メソッド
  def search
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
    @result = params[:q]&.values&.reject(&:blank?)
  end

  def user_params
    params.require(:user).permit(%i[name email phone note admin_note status_id
    option1 option2 option3 option4 option5 option6 option7 option8 option9 option10])
  end
end
