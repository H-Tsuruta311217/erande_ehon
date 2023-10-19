class Public::SearchesController < ApplicationController

  def search
    @range = params[:range]
    @word = params[:word]

    if @range == "Category"
      @categories = Category.looks(params[:search], params[:word])
    else
      @books = Book.looks(params[:search], params[:word])
    end
  end

end
