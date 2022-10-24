# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!, except: :index

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # возвращает коллекцию всех Тестов с дополнительным атрибутом completed(true либо false) модели TestsUser
  # атрибут говорит о полном прохождении Теста текущим пользователем
  def index
    @tests = if user_signed_in?
               Test.includes(:category).select(
                 'tests.*, tests_users.completed, COUNT(questions.id) AS count_questions'
               ).joins(:questions).joins(
                 "LEFT JOIN tests_users ON tests.id = tests_users.test_id AND tests_users.user_id = #{current_user.id}"
               ).group('tests.id')
             else
               Test.includes(:category).joins(:questions).group('tests.id')
             end
  end

  def start
    @test = Test.find(params[:id])
    current_user.start_test(@test)
    redirect_to current_user.find_test_user(@test)
  end

  private

  def rescue_with_test_not_found
    render plain: I18n.t('controller.tests.not_found')
  end
end
