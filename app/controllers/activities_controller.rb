class ActivitiesController < ApplicationController
    
    def index
        @activities = current_user.active_notifications.page(params[:page]).per(20)
    end
    
end    
