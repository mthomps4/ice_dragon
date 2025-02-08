module PostsHelper
  include MarkdownHelper

  def self.render_markdown(text)
    MarkdownHelper.render(text)
  end
end
