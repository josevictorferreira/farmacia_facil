class ApplicationController < ActionController::Base
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to main_app.root_path, alert: exception.message
  end

  def authorized_for_roles(*roles)
    roles.any? { |role_name| current_user.has_role? role_name }
  end
end
