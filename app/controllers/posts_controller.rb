class PostsController < ApplicationController
  before_action :authenticate_user
  before_action :set_post, only: [:show,:edit,:update,:destroy]
  before_action :ensure_correct_user, only:[:edit,:destroy]
  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if params[:back]
      render :new
    else
      if @post.save
        redirect_to posts_path, notice: "投稿を作成しました"
      else
        render :new
      end
    end
  end

  def edit
  end
  def update
    if @post.update(post_params)
      redirect_to posts_path, notice: "投稿を編集しました！"
    else
      render :edit
    end
  end
  # 「今ログインしているユーザーが、そのブログをお気に入り登録しているかどうか」を判断するための処理をしています。
  # find_by(blog_id: @blog.id) で、その全抽出したFavoriteのレコードの中に、このブログのidが存在していれば（このブログがお気に入りに登録されていれば）、そのFavoriteのレコード（user_idとblog_id）を@favoriteに代入します。
  # このブログのidが存在しなければ（このブログがお気に入りに登録されていなければ）、@favoriteにnilを代入します（find_byメソッドは、条件に一致するものがない場合には、nilを返します）。
  def show
    @favorite = current_user.favorites.find_by(post_id: @post.id)
  end

  def destroy
    @post.destroy
    redirect_to posts_path, notice: "投稿を削除しました"
  end

  def confirm
    @post = current_user.posts.build(post_params)
    render :new if @post.invalid?
  end
  # 現在ログインしているユーザーと投稿者が合っているか判断するメソッド

  private
  def post_params
    params.require(:post).permit(:title, :content,:image, :image_cache)
  end
  def set_post
    @post = Post.find(params[:id])
  end
  # 認証済みユーザーかどうか判断するメソッド
  def authenticate_user

    unless logged_in?
      redirect_to new_session_path
    end
  end
  def ensure_correct_user
    # 現在ログインしているユーザーと投稿者が合っていなければ
    unless current_user.id == @post.user_id #IDと比較する。ユーザーIDと比較する
      redirect_to posts_path, notice: "あなたが投稿したもの以外は編集、削除できません。"
    end
  end
end
