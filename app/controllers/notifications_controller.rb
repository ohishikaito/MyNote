class NotificationsController < ApplicationController
  def index
    @notifications = current_user.passive_notifications.includes(%i[visitor tweet room visited]).page(params[:page]).per(20).where.not(visitor_id: current_user.id)
    # @notifications = current_user.passive_notifications.page(params[:page]).per(20)
    @notifications.where(checked: false).each do |notification|
      notification.update_attributes(checked: true)
    end
    # @activities = current_user.active_notifications.includes([:visitor, :tweet, :room, :visited]).page(params[:page]).per(20)
    @activities = current_user.active_notifications.includes(%i[visitor tweet room visited]).page(params[:page]).per(20)
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
