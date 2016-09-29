class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)  

    if @comment.save
      ;flash[:notice] = 'Comment was successfully created.'
      redirect_to(@comment.post)
    else
      flash[:notice] = "Error creating comment: #{@comment.errors}"
      redirect_to(@comment.post)
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:name, :email, :body)
  end
end
