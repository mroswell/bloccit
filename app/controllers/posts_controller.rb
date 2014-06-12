class PostsController < ApplicationController
  # def index
  #   @posts = Post.all
  #   authorize @posts
  # end
  before_filter :get_topic

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
    authorize @post
  end

  def create
  # @post = current_user.posts.build(params.require(:post).permit(:title, :body))
  @post = current_user.posts.build(post_params)
  @post.topic = @topic

  authorize @post
  if @post.save
    redirect_to [@topic, @post], notice: "Post was saved successfully."
  else
    flash[:error] = "There was an error saving the post. Please try again."
    render :new
  end
  end


  def edit
    @post = Post.find(params[:id])
    authorize @post
  end

  def update
    @post = Post.find(params[:id])
    authorize @post
    # if @post.update_attributes(params.require(:post).permit(:title, :body))
    if @post.update_attributes(post_params)
      flash[:notice] = "Post was updated."
      redirect_to [@topic, @post]
    else
      flash[:error] = "There was an error saving the post. Please try again."
      render :edit
    end
  end

  private

  def get_topic
    @topic = Topic.find(params[:topic_id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
