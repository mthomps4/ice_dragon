class MainController < ApplicationController
  def about
  end

  def digital_forge
    @posts = Post.published.where(publication: Post::PUBLICATIONS[:digital_forge])
                 .order(published_on: :desc)
  end

  def hand_tool_armory
    @posts = Post.published.where(publication: Post::PUBLICATIONS[:hand_tool_armory])
                 .order(published_on: :desc)
  end

  def post
    @post = Post.published.find_by(slug: params[:slug])
  end
end
