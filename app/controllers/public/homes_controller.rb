class Public::HomesController < ApplicationController
  def top
    @categories = Category.all
    books = Book.all
    # 最新の4冊の本を取得
    @new_books = books.sort_by { |book| book.created_at }.reverse.first(4)
    # ステータスが「公開済み」の最新の4冊の本を取得
    @books = Book.where(status: :published).order('id DESC').limit(4)
    # お気に入り数が最も多い上位3つの本を取得
    @all_ranks = Book.find(Favorite.group(:book_id).order('count(book_id) desc').limit(3).pluck(:book_id))
  end

  def about
  end

  def new_guest
    Member.find_or_create_by!(id: 'guest_sign_in') do |member|
      member.last_name = "ゲスト"
      member.first_name = "ユーザー"
      member.nickname = "ゲスト"
      member.email = 'guest@example.com'
      member.password = SecureRandom.urlsafe_base64
    end
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end

end
