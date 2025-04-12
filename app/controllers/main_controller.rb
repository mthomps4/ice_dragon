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

  def search_posts
    @search_param = params[:q]
    @q = Post.published
             .order(published_on: :desc)
             .ransack(title_or_description_or_body_cont: @search_param)

    @results = @q.result(distinct: true)

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
