# frozen_string_literal: true

module Authentication
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authenticate_user
    return if current_user.present?

    store_location
    flash[:danger] = t('controller.sessions.access_denied')
    redirect_to login_path
  end

  # Сохраняет запрошенный URL.
  def store_location
    cookies[:forwarding_url] = request.url if request.get?
  end

  # Перенаправляет к сохраненному расположению (или по умолчанию).
  def redirect_back_or(default = root_url)
    redirect_to(cookies[:forwarding_url] || default)
    cookies.delete(:forwarding_url)
  end

  def user_logged_in?
    current_user.present?
  end

  def log_in(user)
    session[:user_id] = user.id
  end

  def log_out
    session.delete(:user_id)
  end
end
