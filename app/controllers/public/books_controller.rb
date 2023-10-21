class Public::BooksController < ApplicationController
  before_action :ensure_correct_member, only: [:edit, :update, :destroy]



  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @post_comment = PostComment.new
    @categories = Category.all
  end

  def index
    @categories = Category.all
    # タブ表示(カテゴリー別or全件)
    if params[:category]
      @category = Category.find_by(name: params[:category])
      @books = @category.books
    else
      @all_books = Book.all
    end
    @books = Book.page(params[:page]).per(7)
  end



  private

  def book_params
    params.require(:book).permit(:title, :item_caption, :book_image, :category_id)
  end

  def ensure_correct_member
    book = Book.find(params[:id])
    unless book.member_id == current_member.id
      redirect_to books_path
    end
  end

end
