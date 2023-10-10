class Public::HomesController < ApplicationController
  def top
    @categories = Category.all
    @books = Book.order('id DESC').limit(4)
  end

  def about
  end
end
