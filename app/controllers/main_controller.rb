class MainController < ApplicationController
  before_action :set_tags_and_collections
  def about
  end

  def blog
    @q = Post.published
             .order(published_on: :desc)
             .ransack(params[:q])
    @posts = @q.result(distinct: false)
               .page(params[:page])
  end

  def post
    @post = Post.published.find_by(slug: params[:slug])
  end

  def connect
  end

  def resume
    @markdown = File.read(Rails.root.join("app", "assets", "content", "resume.md"))
  end

  def search_posts
    @search_param = params[:q]
    @turbo_frame_target = params[:turbo_frame_target] || "search-results"

    # leverage algolia search indexing
    @results = Post.search(@search_param)

    respond_to do |format|
      format.turbo_stream { render "search_posts" }
    end
  end

  private

  def set_tags_and_collections
    @tags = PostTag.includes(:tag).map(&:tag).uniq
    @collections = CollectionPost.includes(:collection).map(&:collection).uniq
  end
end
