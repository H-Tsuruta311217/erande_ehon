class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:update, :edit,:show]
  before_action :authenticate_member!, only: [:show]

  def show
    @member = Member.find(params[:id])
    @favorite_books = current_member.favorites.map(&:book)
    @books = Book.page(params[:page])
  end

  def edit
    ensure_correct_member
    @member = Member.find(params[:id])
  end

  def update
    ensure_correct_member
    if @member.update(member_params)
      redirect_to member_path(@member), notice: "編集内容を保存しました。"
    else
      render :edit
    end
  end

  def confirm
    @member = Member.find(params[:id])
  end

  def withdraw
    @member = Member.find(params[:id])
    # is_activeカラムをtrueに変更することにより削除フラグを立てる
    @member.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行いたしました"
    redirect_to root_path
  end

  def favorites
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :email)
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end

end
