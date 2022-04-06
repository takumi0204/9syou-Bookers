class BooksController < ApplicationController
  def index
     @books = Book.all
     @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(book_params)
    #エラーが出るためbookに@をつけた
    if @book.save
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    #リダイレクト先は投稿した本の詳細
    else
      @books = Book.all
      render :index
      # render :indexから
    end
  end

  def edit
     @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
    #一覧画面へリダイレクト
  end

  private
   #ストロングパラメータ
  def book_params
    params.require(:book).permit(:title, :body)
    #入力したフォームをデータベースから受け取る
  end
end