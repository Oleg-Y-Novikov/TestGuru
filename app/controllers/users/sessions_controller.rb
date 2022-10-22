# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController

  def create
    self.resource = warden.authenticate!(auth_options)
    set_flash_message!(:notice, :signed_in, username: resource.first_name)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: correct_path
  end

  private

  def correct_path
    resource.admin? ? admin_tests_path : after_sign_in_path_for(resource)
  end
end
