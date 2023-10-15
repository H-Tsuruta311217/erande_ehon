class Public::PostCommentsController < ApplicationController

  def create
    @book = Book.find(params[:book_id])
    @post_comment = current_member.post_comments.new(post_comment_params)
    @post_comment.book_id = @book.id
    @member = @book.member
    @post_comment.save
    #redirect_to book_path(@book)
  end



  def edit
  end

  def destroy
    @book = Book.find(params[:book_id])
    @post_comment = PostComment.find_by(id: params[:id], book_id: params[:book_id])
    #redirect_to book_path(params[:book_id])
    @post_comment.destroy
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
