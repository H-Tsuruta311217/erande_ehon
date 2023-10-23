class Public::SearchesController < ApplicationController

  def search
    category_id = params[:category_id]
    @word = params[:word]
    @books = Book.looks(params[:word])
    if category_id.present?
      category_ids = CategoryBook.where(category_id: category_id).pluck(:book_id)
      book_ids = @books.ids
      @books = Book.where(id: category_ids & book_ids)
    end
    @books = @books.where(status: :published).order(params[:desc]).page(params[:page]).per(4)

  end

end
