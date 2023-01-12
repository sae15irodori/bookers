class BooksController < ApplicationController
  def index
    #入力フォーム
    @book = Book.new
  end
  
  def create#入力フォームのデータを保存する(投稿ボタンを押す時点で)
    #1.ﾌｫｰﾑに入力されたデータを受け取る
    #Book.newはフォームに入力されたデータを表している
    #(Bookモデルのtitleとbodyの情報に絞り込み)
    book = Book.new(book_params)
    
    #2.ﾌｫｰﾑに入力したデータをdbに保存する(bookにデータ格納されてる)
    book.save
    
    #詳細ページへリダイレクト
    #@book.idでid番目(その時)にﾌｫｰﾑ入力されたﾃﾞｰﾀの詳細ページへ飛ぶ
    redirect_to book_path
  end

  def show
  end

  def edit
  end
  
  private
  #ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
  end
    #params フォームから送られてくるデータ
    #require 保存するモデル名を指定
    #permit 保存するカラム名を指定
end
