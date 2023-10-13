class Admin::PostCommentsController < ApplicationController
  before_action :authenticate_admin!
  before_action :if_not_admin
    before_action :set_post_comment, only: [:index, :new, :create, :show, :edit, :destroy]

  def edit
  end

  def destroy
    post_comment = PostComment.find(params[:id])
    post_comment.destroy
  end

  private

  def if_not_admin
    redirect_to root_path unless current_member.admin?
  end

  def set_post_comment
    @post_comment = PostComment.find(params[:id])
  end
end
