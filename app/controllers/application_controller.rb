# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[first_name last_name])
  end

  def set_locale
    if session[:lang].present? && params[:lang].blank?
      I18n.locale = session[:lang]
    else
      checking_locale
    end
  end

  def checking_locale
    if params[:lang].present? && I18n.locale_available?(params[:lang])
      session[:lang] = params[:lang]
      I18n.locale = session[:lang]
    else
      I18n.default_locale
    end
  end
end
