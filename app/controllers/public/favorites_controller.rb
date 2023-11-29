class Public::FavoritesController < ApplicationController
  before_action :authenticate_member!

  def create
    if current_member.present?
      @book = Book.find(params[:book_id])
      favorite = current_member.favorites.new(book_id: @book.id)
      favorite.save
      # redirect_to request.referer
    else
      flash[:alert] = "ログインが必要です。"
      # redirect_to request.referer
    end
  end

  def destroy
    if current_member.present?
      @book = Book.find(params[:book_id])
      favorite = current_member.favorites.find_by(book_id: @book.id)
      favorite.destroy
      # redirect_to request.referer
    else
      flash[:alert] = "ログインが必要です。"
      # redirect_to request.referer
    end
  end
end
