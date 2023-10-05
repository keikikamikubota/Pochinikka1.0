class SheetsController < ApplicationController
  
  # インポート設定の処理。各レコードにカラム番号とインポート設定番号を入力し、form_withで送信
  #  (カラムに対する名前の取得は後回し。まずは数字のみ取得し、それぞれのカラム番号に固定の名前を用意しておく)

  def new
    @sheet = Sheet.new
    sample_columns  = {"名前": 1, "email": 2, "phone": 3}
    sample_columns.each do |name, number|
      @sheet.import_details.build(sheet_column_number: number)
      end
  end

  # インポート参照ページの処理
  # def create
  #   @sheet = Sheet.new(sheet_params)
  #   # 適切なリダイレクト先へ
  #   if @sheet.save
  #     redirect_to sheet_path(@sheet)
  #   else
  #     render :new
  #   end
  # end

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


  # def create
  #   @import_detail = ImportDetail.new(import_detail_params)
  #   if @import_detail.save
  #     #参照画面にリダイレクトする
  #     redirect_to import_detail_path(@import_detail)
  #   else
  #     render :new
  #   end
  # end
  #

  # 後回し。最初は全件取得。
  # def スプレッドシートの範囲を絞るメソッド
  # end

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
  # def import_start


  #   user = find_by(email: user.email) || new
  #   row = カラム名["name", "email", "phone", "status",...]
  #   # カラム指定して
  #   更新データ（もしくは新規登録データ）を上の配列をキーにして値として呼び、userに代入
  #   user.attributes = row.to_hash.slice(*updatable_attributes)
  #   # 保存する
  #   user.save　※updateだとnewに使えない
  #   end
  # end

  private
  def sheet_params
    params.require(:sheet).permit(:title, :code,
                                  import_details_attributes: [:sheet_column_number, :selected_title, :sheet_id])
  end

  # def set_sample_sheet
  #   # ハッシュが3つあるのでeach doは3回繰り返されられる
  #   @sample_columns  = {"名前": 1, "email": 2, "phone": 3}
  # end
end

