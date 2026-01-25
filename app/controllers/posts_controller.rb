class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    # 検索処理
    @q = Post.ransack(params[:q])
    @posts = @q.result.includes(:user, image_attachment: :blob).order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "投稿が完了しました"
    else
      flash.now[:alert] = "投稿に失敗しました"
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])

    if @post.update(post_params)
      redirect_to post_path, notice: "投稿を更新しました"
    else
      flash.now[:alert] = "更新に失敗しました"
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, notice: "投稿を削除しました", status: :see_other
  end

  # autocomplete処理
  def autocomplete
    keyword = params[:q]

    posts = Post.where("title LIKE :q OR body LIKE :q", q: "%#{keyword}%").limit(10).pluck(:title)

    render json: posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :image)
  end
end
