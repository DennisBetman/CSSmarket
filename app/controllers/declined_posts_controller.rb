class DeclinedPostsController < ApplicationController
  before_action :authorize
  before_action do
    if !check_user_level(100)
      redirect_to root_path
    end
  end

  def create
    @declined_post = DeclinedPost.new declined_post_params
    @post = Post.find_by_id declined_post_params[:post_id]

    if @declined_post.save
      if @post.update(status: 2)
        PostsMailer.declined(current_user, @post, declined_post_params[:description]).deliver_later

        redirect_to admin_posts_path, flash: { global_message: "Post has been declined." }
      else
        redirect_to admin_posts_path, flash: { global_message: "Something went wrong with updating the post." }
      end
    else
      redirect_to admin_posts_path, flash: { global_message: "Something went wrong with declining the post." }
    end
  end

  private

  def declined_post_params
    params.require(:declined_post).permit :post_id, :description
  end
end
