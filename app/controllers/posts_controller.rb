class PostsController < ApplicationController
  before_action :authorize, except: [:show, :index, :search, :category, :preview, :overview]
  before_action only: [:new] do
    if check_user_level(0)
      redirect_to dashboard_path
    end
  end

  def index
    @posts = Post.group(:parent_id).where(status: 1).order("created_at DESC").all.limit(8).to_a

    user_id_to_name
  end

  def overview
    @posts = Post.group(:parent_id).where(status: 1).order("created_at DESC").all.to_a

    user_id_to_name
  end

  def show
    @post = Post.where(nice_url: params[:nice_url]).where(status: 1).order("created_at DESC").first
    if current_user
      unless @post
        @post = Post.where(nice_url: params[:nice_url]).where(status: 0).order("created_at DESC").first
      end

      if current_user.id == @post.user_id || check_user_level(100)
        @total_posts = Post.where(parent_id: @post.parent_id).where(status: 0).all
        @awaiting_edit = ""

        if @total_posts.length > 0
          @awaiting_edit = Post.where(nice_url: params[:nice_url]).where(status: 0).order("created_at DESC").first
          @post = @awaiting_edit
        end
      end
    end

    unless @post
      @post = Post.where(nice_url: params[:nice_url]).where(status: 1).order("created_at DESC").first
    end

    unless @post
      @post = Post.where(nice_url: params[:nice_url]).where(status: 0).order("created_at DESC").first
    end

    if current_user
      if @post.user_id == current_user.id || check_user_level(100)
      else
        if @post.status == 0
          raise ActionController::RoutingError.new("Not Found")
        end
      end
    else
      if @post.status == 0
        raise ActionController::RoutingError.new("Not Found")
      end
    end

    user = User.select("id", "name").find_by_id(@post.user_id)
    @post.user_name = user.name

    if current_user
      @has_ordered = Order.find_by_post_id_and_user_id(@post.id, current_user.id)
    end
  end

  def preview
    @post = Post.find_by_nice_url params[:nice_url]
  end

  def category
    @posts = Post.group(:parent_id).where(categories: params[:name]).where(status: 1).order("created_at DESC").all.to_a
    @posts_total = @posts ? @posts.count : 0

    user_id_to_name
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.nice_url = @post.title.parameterize
    @post.user_id = current_user.id
    @post.parent_id = SecureRandom.urlsafe_base64(16)

    if @post.save
      redirect_to post_path(@post.nice_url)
    else
      render "new"
    end
  end

  def edit
    @post = Post.where(nice_url: params[:nice_url]).order("created_at DESC").first

    if @post.status == 0
      redirect_to post_path(@post.nice_url)
    end

    if @post.user_id != current_user.id
      redirect_to post_path(@post.nice_url)
    end
  end

  def update
    if post_params[:status]
      @post = Post.find_by_id params[:id]

      if @post.update post_params
        redirect_to post_path(@post.nice_url)

        PostsMailer.approved(current_user, @post).deliver_later
      else
        render "edit"
      end
    else
      @parent_post = Post.find_by_id params[:id]
      @post = Post.new post_params

      @post.nice_url = @parent_post.nice_url
      @post.user_id = current_user.id
      @post.parent_id = @parent_post.parent_id

      if @post.save
        redirect_to post_path(@post.nice_url)
      else
        render "edit"
      end
    end
  end

  def search
    if params[:q].nil?
      @posts = []
    else
      @posts = Post.search params[:q]
    end
  end

  private
    def post_params
      params.require(:post).permit :title, :content, :categories, :price, :image, :file, :license, :status
    end

    def user_id_to_name
      @posts.each do |post|
        user = User.select("id", "name").find_by_id(post.user_id)
        post.user_name = user.name
      end
    end
end
