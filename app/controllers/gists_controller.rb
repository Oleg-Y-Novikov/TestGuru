# frozen_string_literal: true

class GistsController < ApplicationController
  before_action :authenticate_user!

  def create
    @test_user = TestsUser.find(params[:test_user_id])
    service = GistQuestionService.new(@test_user.current_question, current_user)
    @responce = service.create_github_gist

    if @responce[:errors].blank?
      flash[:success] = "#{t('.success')} #{view_context.link_to 'Gist', @responce[:gist].gist_url}"
      redirect_to @test_user
    else
      flash.now[:danger] = t('.failure')
      render 'tests_users/show', responce: @responce, test_user: @test_user
    end
  end
end
