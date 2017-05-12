class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  # helper_method :current_user, :logged_in?
  def require_admin
    unless current_user && current_user.admin?
      redirect_to root_path,
                  {flash: {error: 'You do not have permission to do that.'}}
    end
  end
end
