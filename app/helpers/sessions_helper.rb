module SessionsHelper
  def current_user
    @current_user ||= Admin.find_by(id: session[:admin_id])
  end

  def logged_in?
    current_user.present?
  end
end
