# frozen_string_literal: true

class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]

  def new; end

  def create
    user = User.find_by(email: params[:email].downcase)
    if user&.authenticate(params[:password])
      log_in(user)
      flash[:success] = I18n.t('controller.sessions.welcome', user_name: user.name)
      redirect_back_or
    else
      flash.now[:danger] = I18n.t('controller.sessions.log_in_fail')
      render :new
    end
  end

  def destroy
    log_out
    flash[:success] = I18n.t('controller.sessions.log_out')
    redirect_to login_path
  end
end
