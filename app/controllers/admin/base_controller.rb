# frozen_string_literal: true

class Admin::BaseController < ApplicationController
  layout 'admin'
  before_action :admin_required!

  private

  def admin_required!
    return if current_user.present? && current_user.admin?

    flash[:danger] = I18n.t('controller.admin_base.access_denied')
    redirect_to root_path
  end
end
