class Public::PostCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @comment = current_member.post_comments.new(post_comment_params)
    @comment.book_id = @book.id
    @member = @book.member
    @comment.save
    #redirect_to book_path(@book)
  end



  def edit
  end

  def destroy
    @comment = PostComment.find(params[:id])
    #redirect_to book_path(params[:book_id])
    if @comment.destroy
      render json: { success: "コメントが削除されました" }, status: :ok
    else
      render json: { error: "コメントの削除に失敗しました" }, status: :unprocessable_entity
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
