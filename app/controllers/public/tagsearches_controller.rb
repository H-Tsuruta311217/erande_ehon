class Public::TagsearchesController < ApplicationController

  # カテゴリ検索
  def category_search
    @categories = Category.all
    @books = Category.find(params[:category_id]).books.published.page(params[:page]).per(6)
  end

end
