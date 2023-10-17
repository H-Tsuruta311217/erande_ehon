class Admin::BooksController < ApplicationController

  helper_method :can_delete_comment?

  def new
    @book = Book.new
  end

  def create
    @book = Book.find_or_initialize_by(isbn: params.dig(:book, :isbn))
    if @book.new_record?
      @book.assign_attributes(book_params)
      if @book.save
        redirect_to admin_book_path(@book), notice: "登録しました。"
      else
        render :new, notice: '投稿に失敗しました。'
      end
    else
      flash[:notice] = "登録済みです"
      redirect_to admin_book_path(@book)
    end
  end

  def index
    if params[:title].present?
      @result = RakutenWebService::Books::Book.search(size: 7, title: params[:title])
    else
      @result = []
    end
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

  def search
    if params[:keyword]
      @books = RakutenWebService::Ichiba::Book.search(keyword: params[:keyword])
    end
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
    @search_category = Category.find(params[:category_id]) if params[:category_id]
    @search_word = params[:q][:name_cont] if params[:q].present?
  end

  private

  def book_params
    params.require(:book).permit(:image_url, :title, :item_caption, :status, :isbn, :url, :author, category_ids: [])
  end
end
