class ImportDetailsController < ApplicationController
  # ※スプレッドシートとの紐付けは事前に完了していることとする

  # インポート設定の処理。各レコードにカラム番号とインポート設定番号を入力し、form_withで送信
  #  (カラムに対する名前の取得は後回し。まずは数字のみ取得し、それぞれのカラム番号に固定の名前を用意しておく)
  def new
    変数@import_setting = Import_setting.new
  end


  # インポート参照ページの処理
  def create
    インポート設定で作成した
    @import_setting = Import_setting.find(params[:id])
    @import_setting.save
    参照画面にリダイレクトする
  end

  # 後回し。最初は全件取得
  # def スプレッドシートの範囲を絞るメソッド
  # end

  # showアクションをインポート参照アクションとして利用
  def show
    @import_setting = Import_setting.find(params[:id])
  end

  def import_start
    ユーザーをレコードの数分each do で作成する
    （どこからどこまでインポートするかを設定できればなお良いが後回し）
    もしユーザーのメールアドレスが存在すれば呼び出し、なければ新規作成


    user = find_by(email: user.email) || new
    row = カラム名["name", "email", "phone", "status",...]
    # カラム指定して
    更新データ（もしくは新規登録データ）を上の配列をキーにして値として呼び、userに代入
    user.attributes = row.to_hash.slice(*updatable_attributes)
    # 保存する
    user.save　※updateだとnewに使えない
    end
  end


  private
  def import_setting_params
    prams.require(:インポート設定).permit(%i[シートのカラム番号 インポート設定番号])
  end
end
