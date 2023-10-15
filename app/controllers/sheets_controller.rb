class SheetsController < ApplicationController
  def new
    @sheet = Sheet.new
    repeat_detail
  end

  def create
    @sheet = Sheet.find_or_initialize_by(id: 1)
    # インポート設定が重複しないように過去分を削除
    @sheet.import_details.destroy_all
    #今回は既存のid:1のシートのみと仮定するのでcreateではなくupdateにしている
    if @sheet.update(sheet_params)
      redirect_to sheet_path(@sheet)
    else
      render :new
    end
  end

  # showアクションをインポート参照アクションとして利用
  def show
    @sheet = Sheet.find(params[:id])
  end

  def edit
    @sheet = Sheet.find(params[:id])
  end

  def update
    @sheet = Sheet.find(params[:id])
    if @sheet.update(sheet_params)
      redirect_to sheet_path(@sheet), notice: "更新が完了しました"
    else
      render :edit
    end
  end

  def destroy
    @sheet = Sheet.find(params[:id])
    @sheet.destroy
    redirect_to users_path, flash: {success: "タスクが削除されました"}
  end

  #  インポートの実行をするメソッド。
  def import_exec
    @sheet = Sheet.find(params[:id])
    ImportUsersService.new(@sheet).call
    # フラッシュメッセージを設定
    flash[:notice] = 'インポートが完了しました!'
    # showアクションにリダイレクト
    redirect_to users_path(params[:id])
  end

  # カラム数を取得するメソッド
  def fetch_spreadsheet_data
    fetch_column_service = FetchColumnService.new(Sheet.new)
    google_response = fetch_column_service.fetch_values
    @data = google_response
    render json: { data: @data }
  end

  private

  def repeat_detail
    # リロードするとネストの数がどんどん増えてしまうので、その都度元の発行回数を削除してリセット
    @data.destroy_all if @data.present?
    fetch_column_service = FetchColumnService.new(@sheet)
    @data = fetch_column_service.fetch_values
    @data.size.times { @sheet.import_details.build } if @data.present?
  end

  def sheet_params
    params.require(:sheet).permit(:title, :code,
                                  import_details_attributes: [:id, :sheet_column_number, :selected_title, :sheet_id])
  end
end

