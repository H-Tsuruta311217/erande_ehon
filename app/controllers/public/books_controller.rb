class Public::BooksController < ApplicationController
  def new
    @newbook = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.member_id = current_member.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end


  def show
    @book = Book.find(params[:id])
    @member = @book.member
    @newbook = Book.new
    @post_comment = PostComment.new
  end

  def index
    @books = Book.all
  end

  def edit
    ensure_correct_member
    @book = Book.find(params[:id])
  end

  def update
    ensure_correct_member
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:name, :description, :category)
  end

  def ensure_correct_member
    book = Book.find(params[:id])
    unless book.member_id == current_member.id
      redirect_to books_path
    end
  end

end
