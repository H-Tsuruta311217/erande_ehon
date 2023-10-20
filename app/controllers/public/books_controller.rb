class Public::BooksController < ApplicationController
  before_action :ensure_correct_member, only: [:edit, :update, :destroy]



  def show
    @book = Book.find(params[:id])
    @newbook = Book.new
    @post_comment = PostComment.new
    @categories = Category.all
  end

  def index
    @books = Book.page(params[:page]).per(6)
    @all_books = Book.all
    @categories = Category.all
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
