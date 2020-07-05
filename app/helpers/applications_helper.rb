module ApplicationsHelper

  def current_user_has?(instance)
    user_signed_in? && current_user == instance.user || user_signed_in? && current_user.admin?
  end

end
