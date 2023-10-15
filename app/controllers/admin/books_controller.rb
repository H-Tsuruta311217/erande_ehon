class Admin::BooksController < ApplicationController

  helper_method :can_delete_comment?

  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)

    if params[:draft].present?
      @book.status = :draft
    else
      @book.status = :published
    end

    if @book.save
      redirect_to admin_book_path(@book), notice: "登録しました。"
    else
      render :new, notice: '投稿に失敗しました。'
    end
  end

  def index
    @books = Book.all
    @categories = Category.all
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @books = @category.books.recent.page(params[:page])
    else
      @books = Book.where(status: :published).order(params[:desc]).page(params[:page]).per(5)
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to redirect_path, notice: notice_message
    else
      render :edit
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to admin_books_path
  end

  def confirm
    # @book = Book.find(params[:id])
    @books = Book.where(status: :draft).order('created_at DESC').page(params[:page]).per(5)
  end

  private

  def book_params
    params.require(:book).permit(:book_image, :name, :description, :status, category_ids: [])
  end
end
