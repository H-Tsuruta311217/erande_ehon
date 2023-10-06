class Public::MembersController < ApplicationController

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    member = current_member
    member.update(member_params)
    redirect_to members_mypage_path
  end

  private

  def customer_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :email)
  end
end
