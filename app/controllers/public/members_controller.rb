class Public::MembersController < ApplicationController
  before_action :ensure_correct_member, only: [:update, :edit,:show]
  before_action :authenticate_member!, only: [:show]

  def show
    @member = Member.find(params[:id])
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

  private

  def customer_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :email)
  end

  def ensure_correct_member
    @member = Member.find(params[:id])
    unless @member == current_member
      redirect_to member_path(current_member)
    end
  end

end
