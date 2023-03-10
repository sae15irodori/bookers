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

    if @book.save#2.ﾌｫｰﾑで入力したデータをdbに保存する(bookにデータ格納されてる)
      #3.保存ﾃﾞｰﾀがあれば、book_pathで詳細ページへリダイレクト
      #@book.idでid番目(その時)にﾌｫｰﾑ入力されたﾃﾞｰﾀの詳細ページへ飛ぶ
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)

    else#保存するものがなければ
     @books = Book.all
     render :index #一覧ページを再表示
    end
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
    #更新ﾎﾞﾀﾝ押したら､更新したいidのﾃﾞｰﾀを取得
    @book = Book.find(params[:id])

    if @book.update(book_params)#上で取得したﾃﾞｰﾀを更新する
      #ﾃﾞｰﾀの存在がtrueであれば
       flash[:notice] = "Book was successfully updated."#ﾌﾗｯｼｭメッセージ
      redirect_to book_path(@book.id)#book_pathで詳細ページへ飛ぶ｡book.idで上で取得したデータと同じidを指定してる

    else #ﾃﾞｰﾀの存在falseなら
    #editｱｸｼｮﾝに飛ぶけど、使うｲﾝｽﾀ変数はこのｱｸｼｮﾝ内と同じだからこれだけで良い
    render :edit#editページへリダイレクト
    end

  end



  def destroy#一覧ページでデータを削除する時に使われる
    #bookはBookモデルから削除するidのデータを探す変数
    #削除ボタン押したら削除したいidのﾃﾞｰﾀを取得してくれる
    book = Book.find(params[:id])

    #上で探してきたデータを削除
    book.destroy

    #一覧ページを再表示
    redirect_to books_path
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
