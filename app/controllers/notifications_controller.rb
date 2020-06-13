class NotificationsController < ApplicationController
    
    def index
        @notifications = current_user.passive_notifications.includes([:visitor, :tweet, :room, :visited]).page(params[:page]).per(20).where.not(visitor_id: current_user.id)
        # @notifications = current_user.passive_notifications.page(params[:page]).per(20)
        @notifications.where(checked: false).each do |notification|
            notification.update_attributes(checked: true)
        end
        # @activities = current_user.active_notifications.includes([:visitor, :tweet, :room, :visited]).page(params[:page]).per(20)
        @activities = current_user.active_notifications.includes([:visitor, :tweet, :room, :visited]).page(params[:page]).per(20)
    end
# has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id'
# has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id'
# belongs_to :visitor, class_name: 'User', foreign_key: 'visitor_id', optional: true
# belongs_to :visited, class_name: 'User', foreign_key: 'visited_id', optional: true
end
