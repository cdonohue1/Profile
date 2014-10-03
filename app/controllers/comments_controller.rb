class CommentsController < ApplicationController
  def index
    @comment = Comment.all
  end

  def create
    @post = find_post
    @comment = @post.comments.build(comment_params)
    if @comment.save
      redirect_to post_path(@post), notice: 'comment added'
    else
      redirect_to :back, alert: 'Must be more than five charicters'
    end
  end


  def update
  @comment = Comment.find(params[:post_id])

    if @comment.update_attributes(post_params)
        redirect_to posts_path
    else
        render :edit
    end
  end


  def destroy
    @post = find_post
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to posts_path(@post)
  end
 
  private

  def find_post
    Post.find(params[:post_id])
  end

    def comment_params
      params.require(:comment).permit(:body)
    end
end