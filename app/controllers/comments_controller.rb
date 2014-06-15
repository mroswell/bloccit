class CommentsController < ApplicationController

  #Y def create
  #   # @post = current_user.posts.build(params.require(:post).permit(:title, :body))
  # Y-ish  @comment = current_user.comments.build()

  # Y  authorize @comment
  # Y  if @comment.save
  #     redirect_to [@topic, @post], notice: "Comment was saved successfully."
  #  Y else
  #  Y  flash[:error] = "There was an error saving the comment. Please try again."
  #     render :new
  #  Y end
  # end

    def create
    @topic = Topic.find( params[:topic_id] )
    @post = @topic.posts.find( params[:post_id] )
    @comments = @post.comments

    @comment = current_user.comments.build( comment_params )
    @comment.post = @post
    @new_comment = Comment.new

    authorize @comment

    if @comment.save
      flash[:notice] = "Comment was created."
    else
      flash[:error] = "There was an error saving the comment. Please try again."
    end

    respond_with(@comment) do |f|
      f.html { redirect_to [@topic, @post] }
    end
  end

  private

    def comment_params
    params.require(:comment).permit(
      :body,
      :post_id
    )
  end

  #   def post_params
  #   params.require(:post).permit(:title, :body, :image)
  # end
end
