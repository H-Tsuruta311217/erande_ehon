class Public::PostCommentsController < ApplicationController
  before_action :set_post_comment, only: [:destroy]

  def create
    @book = Book.find(params[:book_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comment.book_id = @book.id
    @post_comment.save
    #redirect_to book_path(@book)
  end



  def edit
  end

  def destroy
    @book = Book.find(params[:book_id])
    @post_comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
    #redirect_to book_path(params[:book_id])　非同期化のためコメントアウト
    if current_member == @post_comment.member
      @post_comment.destroy
      render json: { message: 'コメントが削除されました' }, status: :ok
    else
      render json: { message: '他人のコメントは削除できません' }, status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end
  
  def set_post_comment
    @post_comment = current_member.post_comments.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { message: 'コメントが見つかりません' }, status: :not_found
  end

end
