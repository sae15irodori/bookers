class BooksController < ApplicationController
  def index#一覧ページ
  
    #一覧ページでは全てのデータを表示するから複数形の変数にしとく
    #一覧ページに飛ぶ事で､すべてのデータが取得される  
    @books = Book.all
  
    #入力フォーム
    @book = Book.new
  end
  
  def create#入力フォームのデータを保存する
  
    #1.ﾌｫｰﾑに入力されたデータを受け取る
    @book = Book.new(book_params)#Book.newはフォームに入力されたデータを表している。このｱｸｼｮﾝ内での@book変数は､入力ﾌｫﾑｰで､入力したﾃﾞｰﾀの事
    
    @book.save#2.ﾌｫｰﾑで入力したデータをdbに保存する(bookにデータ格納されてる)
    
    #3.book_pathで詳細ページへリダイレクト
    #@book.idでid番目(その時)にﾌｫｰﾑ入力されたﾃﾞｰﾀの詳細ページへ飛ぶ
    redirect_to book_path(@book.id)
  end
  
  def destroy#一覧ページでデータを削除する時に使われる
    #bookはBookモデルから削除するidのデータを探す変数
    #削除ボタン押したら削除したいidのﾃﾞｰﾀを取得してくれる
    book = Book.find(params[:id])
    
    #上で探してきたデータを削除
    book.destroy
    
    #一覧ページを再表示
    render :index
  end
 
  
  def show#詳細ページ
    #@bookにはcreateアクションの時にdbに保存したデータが入ってる
    #このｱｸｼｮﾝ内における@bookは特定idのﾃﾞｰﾀをBookモデルから探すという変数
    @book = Book.find(params[:id])
  end



  def edit#編集ページ
   #このｱｸｼｮﾝ内における@bookは特定idのﾃﾞｰﾀをBookモデルから探すという変数
   #編集ボタンを押すと､編集したいidのﾃﾞｰﾀをﾓﾃﾞﾙ経由で取得する
    @book = Book.find(params[:id])
  end
  
  def update#編集ページでﾃﾞｰﾀを更新する時に使われる
  
    #このbookは、Bookモデルから編集するidのデータを探す変数
    #更新ﾎﾞﾀﾝ押したら､更新したいidのﾃﾞｰﾀを取得してくれる
    book = Book.find(params[id])
    
    #上で探してきたデータを更新する
    book.update(list_params)
    
    #book_pathで詳細ページへ飛ぶという意味
    #book.idで上で取得したデータと同じidを指定している
    redirect_to book_path(book.id)
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
