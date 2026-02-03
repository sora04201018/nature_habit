class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_likeable

  def create
    @like = @likeable.likes.build(user: current_user)

    if @like.save
      respond_to do |format|
        format.turbo_stream
        format.html { redirect_back fallback_location: root_path }
      end
    end
  end

  def destroy
    @like = current_user.likes.find_by!(likeable: @likeable)
    @like.destroy!

    respond_to do |format|
      format.turbo_stream
      format.html { redirect_back fallback_location: root_path }
    end
  end

  private

  def set_likeable
    if params[:habit_id]
      @likeable = Habit.find_by!(uuid: params[:habit_id])

    elsif params[:post_id]
      @likeable = Post.find_by!(uuid: params[:post_id])
    end
  end
end
