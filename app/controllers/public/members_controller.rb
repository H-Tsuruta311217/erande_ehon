class Public::MembersController < ApplicationController

  def show
    @member = current_member
  end

  def edit
    @member = current_member
  end

  def update
    member = current_member
    member.update(member_params)
    redirect_to members_mypage_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name,
                                     :first_name,
                                     :nickname,
                                     :email
                                     )
  end
end
