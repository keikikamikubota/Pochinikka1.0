class ImportDetailsController < ApplicationController
  # インポート完了まではbefore_actionを使って、以下のメソッドでカラム名とカラム番号を呼び出している。
  #   ユーザーをレコードの数分each do で作成する
  #   （どこからどこまでインポートするかを設定できればなお良いが後回し）
  #   もしユーザーのメールアドレスが存在すれば呼び出し、なければ新規作成
  # before_action :set_sample_sheet, only: %w(new create show edit update destroy)


  # インポート設定の処理。各レコードにカラム番号とインポート設定番号を入力し、form_withで送信
  #  (カラムに対する名前の取得は後回し。まずは数字のみ取得し、それぞれのカラム番号に固定の名前を用意しておく)

  # def new
  #   @import_detail = ImportDetail.new
  # end
  #
  # # インポート参照ページの処理
  # def create
  #   @import_detail = ImportDetail.new
  #   # Rails.logger.debug "PARAMS: #{params.inspect}"
  #   import_detail_params[:import_details].values.each do |param|
  #     ImportDetail.create!(param.permit(:sheet_column_number, :selected_title, :sheet_id))
  #   end
  #   # 適切なリダイレクト先へ
  #   if @import_detail.save
  #     redirect_to import_detail_path(@import_detail)
  #   else
  #     render :new
  #   end
  # end


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
  # def show
  #   @import_detail = ImportDetail.find(params[:id])
  # end
  #
  # def edit
  #   @import_detail = ImportDetail.find(params[:id])
  # end
  #
  # def update
  #   @import_detail = ImportDetail.find(params[:id])
  #   if @import_detail.update(import_detail_params)
  #     redirect_to import_detail_path(@import_detail), notice: "更新が完了しました"
  #   else
  #     render :edit
  #   end
  # end

  def destroy
    @import_detail = ImportDetail.find(params[:id])
    @import_detail.destroy
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
  # def import_detail_params
  #   params.require(:import_detail).permit(import_details: [:sheet_column_number, :selected_title, :sheet_id])
  # end
  #
  # def set_sample_sheet
  #   # ハッシュが3つあるのでeach doは3回繰り返されられる
  # @sample_columns  = {"名前": 1, "email": 2, "phone": 3}
  # end
end