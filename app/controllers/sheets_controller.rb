class SheetsController < ApplicationController
  def index
    @sheets = Sheet.all
  end

  def new
    @sheet = Sheet.new
    build_default_details
  end

  def create
    @sheet = Sheet.new(sheet_params)
    if @sheet.save
      flash[:notice] = "シートの作成に成功しました。"
      redirect_to sheet_path(@sheet)
    else
      flash[:alert] = "入力に不備があります。"
      render :new
    end
  end

  # showアクションをインポート参照アクションとして利用
  def show
    @sheet = Sheet.find(params[:id])
    @user = User.new
  end

  def edit
    @sheet = Sheet.find(params[:id])
    repeat_detail
  end

  def update
    @sheet = Sheet.find(params[:id])
    if @sheet.update(sheet_params)
      redirect_to sheet_path(@sheet), notice: "更新が完了しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @sheet = Sheet.find(params[:id])
    @sheet.destroy
    redirect_to sheets_path, flash: {success: "シートが削除されました"}
  end

  def import_exec
    @sheet = Sheet.find(params[:id])
    spreadsheet_id = @sheet.spreadsheet_id
    range = @sheet.range
    import_users_service = ImportUsersService.new(@sheet, spreadsheet_id, range)
    if import_users_service.call
      flash[:notice] = 'インポートが完了しました！'
      redirect_to users_path, turbolinks: false
    else
      @user = import_users_service.user
      flash[:alert] = 'インポートに失敗しました。'
      render 'sheets/show'
    end
  end

  # カラム数を取得するメソッド
  def fetch_spreadsheet_data
    fetch_column_service = FetchColumnService.new(Sheet.new)
    google_response = fetch_column_service.fetch_values
    @data = google_response
    render json: { data: @data }
  end

  private

  # シート名が間違っている時apis::ClientErrorになるので、その際は別メソッドに切り替える
  def repeat_detail
    begin
      fetch_column_service = FetchColumnService.new(@sheet, @sheet.spreadsheet_id, @sheet.range)
      @data = fetch_column_service.fetch_values
      if @data.present?
        # リロードするとネストの数がどんどん増えてしまうので、その都度元の発行回数を削除してリセット
        @data.clear
        @data.size.times { @sheet.import_details.build }
      else
        build_default_details
      end
    rescue Google::Apis::ClientError
      build_default_details
    end
  end

  def build_default_details
    @sheet.import_details.destroy_all if @sheet.import_details.present?
    10.times { @sheet.import_details.build}
  end

  def sheet_params
    params.require(:sheet).permit(:title, :code, :spreadsheet_id, :range,
                                  import_details_attributes: [:id, :sheet_column_number, :selected_title])
  end
end

