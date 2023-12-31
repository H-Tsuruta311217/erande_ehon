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
      @category = Category.find_by(name: params[:category]) # カテゴリー名で検索
      if @category
        @books = @category.books.where(status: :published).page(params[:page]).per(4)
      else
        # カテゴリーが見つからなかった場合の処理
        flash[:error] = "カテゴリーが見つかりませんでした。"
        # ステータスが公開になっているもののみ表示
        @books = Book.where(status: :published).order(params[:desc]).page(params[:page]).per(4)
      end
    else
      @books = Book.where(status: :published).order(params[:desc]).page(params[:page]).per(4) #公開中のものを新しい順に４つずつ
    end
  end



  private

  def book_params
    params.require(:book).permit(:title, :item_caption, :image_url, category_ids: [])
  end

  def ensure_correct_member
    book = Book.find(params[:id])
    unless book.member_id == current_member.id
      redirect_to books_path
    end
  end

end
