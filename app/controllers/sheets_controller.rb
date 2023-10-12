class SheetsController < ApplicationController
  def new
    @sheet = Sheet.new
    import_service = ImportUsersService.new(@sheet)
    # リロードするとネストの数がどんどん増えてしまうので、その都度元の発行回数を削除してリセット
    @sheet_values.destroy_all if @sheet_values.present?
    @sheet_values = import_service.sheet_values
    @sheet_values.first.size.times { @sheet.import_details.build } if @sheet_values.present?
  end

  def create
    # ID 1のSheetを検索し、存在しない場合は新しく作成
    @sheet = Sheet.find_or_initialize_by(id: 1)
    # インポート設定が重複しないように過去分を削除
    @sheet.import_details.destroy_all
    #今回は既存のid:1のシートと仮定するのでcreateではなくupdateにしている
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
    if @sheet.update(import_detail_params)
      redirect_to import_detail_path(@sheet), notice: "更新が完了しました"
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

  def fetch_spreadsheet_data
    fetch_column_service = FetchColumnService.new(Sheet.new)
    google_response = fetch_column_service.fetch_values
    @data = google_response.values
    binding.pry
    render json: { data: @data }
  end
  
  private

  def sheet_params
    params.require(:sheet).permit(:title, :code,
                                  import_details_attributes: [:sheet_column_number, :selected_title, :sheet_id])
  end
end

