# frozen_string_literal: true

class TestsUsersController < ApplicationController
  before_action :set_test_user, only: %i[show result update restart]

  def show; end

  def result; end

  def update
    @test_user.accept!(params[:answer_ids])

    if @test_user.completed?
      TestsMailer.completed_test(@test_user).deliver_now
      redirect_to result_tests_user_path(@test_user)
    else
      render :show
    end
  end

  def restart
    @test_user.start_test_user_params!
    redirect_to @test_user
  end

  private

  def set_test_user
    @test_user = TestsUser.find(params[:id])
  end
end
