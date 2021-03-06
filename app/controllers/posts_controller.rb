class PostsController < ApplicationController
  layout "preview", only: [:preview]

  before_action :authorize, except: [:show, :index, :search, :category, :preview, :overview]
  before_action only: [:new] do
    if check_user_level("regular")
      redirect_to user_settings_path
    end
  end

  def index
    @posts_total = Post.group(:parent_id).where(status: 1).all.to_a.count
    @posts = Post.group(:parent_id).where(status: 1).order("created_at DESC").all.limit(8).to_a

    user_id_to_name

    @posts = @posts.reject { |p| p.user_name == "[deleted]" }
  end

  def overview
    @posts = Post.group(:parent_id).where(status: 1).order("created_at DESC").all.to_a

    user_id_to_name

    @posts = @posts.reject { |p| p.user_name == "[deleted]" }
  end

  def show
    @post = Post.where(nice_url: params[:nice_url]).where(status: 1).order("created_at DESC").first
    if current_user
      unless @post
        @post = Post.where(nice_url: params[:nice_url]).where.not(status: 1).order("created_at DESC").first
      end

      if current_user.id == @post.user_id || check_user_level("admin")
        @total_posts = Post.where(parent_id: @post.parent_id).where.not(status: 1).all
        @awaiting_edit = ""

        if @total_posts.length > 0
          @awaiting_edit = Post.where(nice_url: params[:nice_url]).where.not(status: 1).order("created_at DESC").first
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
      if @post.user_id == current_user.id || check_user_level("admin")
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

    @author = User.select("id", "name", "nano_address", "status").find_by_id(@post.user_id)

    if current_user
      @has_ordered = false

      parent_id = @post.parent_id
      posts = Post.where(parent_id: parent_id).order("created_at DESC").all.to_a

      posts.each do |post|
        order = Order.find_by_post_id_and_user_id(post.id, current_user.id)

        if order
          @has_ordered = true
        end
      end
    end
  end

  def preview
    @post = Post.find_by_nice_url params[:nice_url]
  end

  def category
    @posts = Post.group(:parent_id).where(categories: params[:name]).where(status: 1).order("created_at DESC").all.to_a
    @posts_total = @posts ? @posts.count : 0

    user_id_to_name

    @posts = @posts.reject { |p| p.user_name == "[deleted]" }
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.nice_url = @post.title.parameterize
    @post.user_id = current_user.id
    @post.parent_id = SecureRandom.urlsafe_base64(16)

    respond_to do |format|
      if @post.save
        format.html { redirect_to post_path(@post.nice_url) }
      else
        format.html { render "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
        format.js { render layout: false, content_type: "text/javascript" }
      end
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

      if post_params[:image].nil?
        @post.image = @parent_post.image
      end

      if post_params[:file].nil?
        @post.file = @parent_post.file
      end

      @post.nice_url = @parent_post.nice_url
      @post.user_id = current_user.id
      @post.parent_id = @parent_post.parent_id

      respond_to do |format|
        if @post.save
          format.html { redirect_to post_path(@post.nice_url) }
        else
          format.html { render "edit" }
          format.json { render json: @post.errors, status: :unprocessable_entity }
          format.js { render layout: false, content_type: "text/javascript" }
        end
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
      user = User.select("id", "name", "status").find_by_id(post.user_id)

      if user.deleted?
        post.user_name = "[deleted]"
      else
        post.user_name = user.name
      end
    end
  end
end
