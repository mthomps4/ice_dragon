class MainController < ApplicationController
  def about
  end

  def digital_forge
    @q = Post.published.where(publication: Post::PUBLICATIONS[:digital_forge])
             .order(published_on: :desc)
             .ransack(params[:q])
    @posts = @q.result(distinct: false)
               .page(params[:page])
  end

  def hand_tool_armory
    @q = Post.published.where(publication: Post::PUBLICATIONS[:hand_tool_armory])
             .order(published_on: :desc)
             .ransack(params[:q])
    @posts = @q.result(distinct: false)
               .page(params[:page])
  end

  def post
    @post = Post.published.find_by(slug: params[:slug])
  end
end
