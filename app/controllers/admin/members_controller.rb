class Admin::MembersController < ApplicationController
  before_action :authenticate_admin!, except: [:top]

  def index
    @members = Member.page(params[:page]).per(10)
  end

  def show
    @member = Member.find(params[:id])
  end

  def edit
    @member = Member.find(params[:id])
  end

  def update
    @member = Member.find(params[:id])
    if @member.update(member_params)
      flash[:notice] = "会員情報を更新しました"
      redirect_to admin_member_path(@member)
    else
      render :edit
    end
  end

  private

  def member_params
    params.require(:member).permit(:last_name, :first_name, :nickname, :email, :is_active, :introduction)
  end

  def get_member_id
    @member = Member.find(params[:id])
  end

end
