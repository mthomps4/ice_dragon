class MainController < ApplicationController
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
end
