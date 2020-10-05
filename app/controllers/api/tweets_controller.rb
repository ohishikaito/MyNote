class Api::TweetsController < ApplicationController
  # 受け取ったテキストをマークダウンに変換するメソッド
  def preview
    @html = view_context.markdown(params[:text])
  end
end
