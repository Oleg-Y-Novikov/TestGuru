# frozen_string_literal: true

class UsersController < ApplicationController
  skip_before_action :authenticate_user, only: %i[new create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_back_or
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @current_user.update(user_params)
      flash[:success] = I18n.t('controller.users.changes_saved')
      redirect_to @current_user
    else
      render :edit
    end
  end

  def destroy
    log_out
    @current_user.destroy
    flash[:success] = I18n.t('controller.users.profile_deleted')
    redirect_to root_url
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
