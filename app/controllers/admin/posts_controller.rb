class Admin::PostsController < AdminController
  before_action :set_post, only: [ :show, :edit, :update, :destroy ]
  layout "admin"

  def index
    @posts = Post.all.order(created_at: :desc)
  end

  def show
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = Post.new(post_params)

    if @post.save
      redirect_to admin_post_path(@post), notice: "Post was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @post.update(post_params)
      redirect_to admin_post_path(@post), notice: "Post was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @post.archived = true
    @post.save
    redirect_to admin_posts_url, notice: "Post was successfully deleted."
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(
      :title,
      :description,
      :meta_title,
      :meta_description,
      :keywords,
      :featured_image,
      :featured_alt_text,
      :og_image,
      :og_image_alt_text,
      :canonical_url,
      :body,
      :published,
      :archived,
      :published_on,
      :publication,
      tag_ids: [])
  end
end
