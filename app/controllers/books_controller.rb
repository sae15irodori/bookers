class BooksController < ApplicationController
  def index
    #入力フォーム
    @book = Book.new
  end
  
  def create#入力フォームのデータを保存する
  
    #1.ﾌｫｰﾑに入力されたデータを受け取る
    #Book.newはフォームに入力されたデータを表している
    #@book変数が入力ﾌｫｰﾑから､入力したﾃﾞｰﾀに更新された
    @book = Book.new(book_params)
    
    #2.ﾌｫｰﾑに入力したデータをdbに保存する(bookにデータ格納されてる)
    @book.save
    
    #詳細ページへリダイレクト
    #@book.idでid番目(その時)にﾌｫｰﾑ入力されたﾃﾞｰﾀの詳細ページへ飛ぶ
    redirect_to book_path(@book.id)
  end
  
  def show#詳細ページ
    #@bookにはcreateアクションの時にdbに保存したデータが入ってる
    #@book変数が、特定idのﾃﾞｰﾀを探すという変数に更新された
    @book = Book.find(params[:id])
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
