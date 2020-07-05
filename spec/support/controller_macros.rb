module ControllerMacros
  def login_user(user)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    sign_in user
  end
end
