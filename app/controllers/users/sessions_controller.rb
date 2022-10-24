# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def create
    super
    flash[:notice] = I18n.t('controller.sessions.welcome', user_name: resource.first_name)
  end

  private

  def after_sign_in_path_for(resource)
    stored_location_for(resource) ||
      if resource.admin?
        admin_tests_path
      else
        super
      end
  end
end
