module MarkdownHelper
  def markdown(text)
    unless @markdown
      options = {
        hard_wrap: true,

        filter_html: true,
        autolink: true,
        space_after_headers: true,
        no_intra_emphasis: true,
        fenced_code_blocks: true,
        tables: true,
        xhtml: true,
        lax_html_blocks: true,
        strikethrough: true

      }
      extensions = {
        # no_intra_emphasis: true,
        # tables: true,
        # fenced_code_blocks: true,
        # autolink: true,
        # quote: true
      }
      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end

    @markdown.render(text).html_safe
  end
end
