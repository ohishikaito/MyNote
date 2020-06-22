class Api::TweetsController < ApplicationController
  def preview
    @html = view_context.markdown(params[:text])
  end
end
