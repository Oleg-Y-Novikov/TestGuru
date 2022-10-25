# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :authenticate_user!, except: :index

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # возвращает коллекцию всех Тестов с дополнительным атрибутом completed(true либо false) модели TestsUser
  # атрибут говорит о полном прохождении Теста текущим пользователем
  def index
    @tests = if user_signed_in?
               Test.show_tests_for_current_user(current_user)
             else
               Test.includes(:category, :questions).joins(:questions).group('tests.id')
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
