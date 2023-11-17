class Public::SearchesController < ApplicationController

  # 検索窓での検索
  def search
    category_id = params[:category_id]
    @word = params[:word]
    @books = Book.looks(params[:word])
    if category_id.present?
      category_ids = CategoryBook.where(category_id: category_id).pluck(:book_id)
      book_ids = @books.ids
      @books = Book.where(id: category_ids & book_ids) #カテゴリIDと検索結果の両方に存在する書籍IDを見つけそれらのIDを持つ書籍を取得
    end
    @books = @books.where(status: :published).order(params[:desc]).page(params[:page]).per(4) #公開中のものを新しい順に４つずつ
  end

end
