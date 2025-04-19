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
    @results = []
    @turbo_frame_target = params[:turbo_frame_target] || "search-results"

    unless @search_param.blank?
      # leverage algolia search indexing
      hits = Post.search(@search_param, {
        snippetEllipsisText: "...",
        attributesToSnippet: [ "title:20", "description:20", "body:20" ],
        highlightPreTag: "<em>",
        highlightPostTag: "</em>"
      })
      @results = hits.raw_answer[:hits].map do |hit|
        {
          slug: hit[:slug],
          featured_image: hit[:featured_image],
          title: hit[:_snippetResult][:title][:value],
          description: hit[:_snippetResult][:description][:value],
          body: hit[:_snippetResult][:body][:value]
        }
      end
    end

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
