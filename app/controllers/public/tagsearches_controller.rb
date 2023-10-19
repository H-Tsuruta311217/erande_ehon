class Public::TagsearchesController < ApplicationController

  def category_search
    @categories = Category.all
    @category_id = params[:category_id]
    @books = Book.where(category_id: @category_id).page(params[:page]).per(6)
  end

end
