class Public::TagsearchesController < ApplicationController

  def category_search
    @categories = Category.all
    @books = Category.find(params[:category_id]).books.page(params[:page]).per(6)
  end

end
