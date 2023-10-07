class Admin::BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      redirect_to admin_book_path(@book), notice: "登録しました。"
    else
      render :new
    end
  end

  def index
     @books = Book.page(params[:page]).per(10)
  end

  def edit
    @book = Books.find(params[:id])
  end

  def update
    @book = Books.find(params[:id])
    if @book.update(book_params)
      redirect_to admin_book_path(@book), notice: "変更しました。"
    else
      render :edit
    end
  end

  def show
    @book = Books.find(params[:id])
  end
end
