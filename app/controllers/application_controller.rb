class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :avatar])
    end

# bulletを無効にするメソッド---------------------------------------------------------------------------------------
  around_action :skip_bullet, if: -> { defined?(Bullet) }

  def skip_bullet
    previous_value = Bullet.enable?
    Bullet.enable = false
    yield
  ensure
    Bullet.enable = previous_value
  end
# -------------------------------------------------------------------------------------------------------------------------
    
end
