module MarkdownHelper
  def markdown(text)
    unless @markdown
      options = {
        hard_wrap: true, # 改行を反映
        filter_html: true, # HTMLタグを出力しない。h1タグ等。XSS対策済み
        space_after_headers: true # 「#」の後に空白がないと見出し(h1)と認めない
      }
      extensions = {
        autolink: true, # URLをクリックすると飛べる
        fenced_code_blocks: true, # Qiitaのようにコードを装飾できる「```」
        tables: true, # テーブル表もどきになる「| td | td | td |＆|---|---|---|」
        strikethrough: true # 取り消し線を有効「~~AA~~」
      }
      renderer = Redcarpet::Render::HTML.new(options)
      @markdown = Redcarpet::Markdown.new(renderer, extensions)
    end
    @markdown.render(text).html_safe
  end
end
