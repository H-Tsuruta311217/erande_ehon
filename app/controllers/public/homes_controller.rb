class Public::HomesController < ApplicationController
  def top
    @categories = Category.all
    books = Book.all
    @new_books = books.sort_by { |book| book.created_at }.reverse.first(4)
    @books = Book.order('id DESC').limit(4)
    @all_ranks = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
  end

  def about
  end

  def new_guest
    Member.find_or_create_by!(id: 'guest_sign_in') do |member|
      member.last_name = "ゲスト"
      member.first_name = "ユーザー" # ここでイコール "=" を使用していないと思われるエラーを修正
      member.nickname = "ゲスト"
      member.email = 'guest@example.com'
      member.password = SecureRandom.urlsafe_base64
    end
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
