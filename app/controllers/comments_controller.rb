class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_commentables

  def create
    @comment = @commentable.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      flash.now[:notice] = "コメントを投稿しました"
    else
      flash.now[:alert] = "コメントを作成できませんでした"
    end
  end

  def destroy
    @comment = @commentable.comments.find(params[:id])

    if @comment.user === current_user
      @comment.destroy!
      flash.now[:notice] = "コメントを削除しました"
    else
      flash.now[:alert] = "削除権限がありません"
      redirect_back fallback_location: dashboard_path
    end
  end

  private

  def set_commentables
    if params[:habit_id]
      @commentable = Habit.find(params[:habit_id])

    elsif params[:post_id]
      @commentable = Post.find(params[:post_id])
    end
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end
