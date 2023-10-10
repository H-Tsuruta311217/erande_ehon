class Admin::BooksController < ApplicationController

  before_action :authenticate_admin!, except: [:top]

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
     @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @books = @category.books.recent.page(params[:page])
    else
      @books = Book.page(params[:page]).per(10)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to admin_book_path(@book), notice: "変更しました。"
    else
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  private

  def book_params
    params.require(:book).permit(:book_image, :name, :description, { category_ids: [] })
  end
end
