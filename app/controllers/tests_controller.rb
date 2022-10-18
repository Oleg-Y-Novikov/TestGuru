# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :find_test, only: %i[show edit update destroy start]
  skip_before_action :authenticate_user, only: :index

  rescue_from ActiveRecord::RecordNotFound, with: :rescue_with_test_not_found

  # возвращает коллекцию всех Тестов с дополнительным атрибутом completed(true либо false) модели TestsUser
  # атрибут говорит о полном прохождении Теста текущим пользователем
  def index
    @tests = if user_logged_in?
               Test.includes(:category).select(
                 'tests.*, tests_users.completed, COUNT(questions.id) AS count_questions'
               ).joins(:questions).joins(
                 "LEFT JOIN tests_users ON tests.id = tests_users.test_id AND tests_users.user_id = #{@current_user.id}"
               ).group('tests.id')
             else
               Test.includes(:category, :questions)
             end
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = @current_user.tests_author.build(test_params)
    if @test.save
      redirect_to @test
    else
      render :new
    end
  end

  def edit; end

  def update
    if @test.update(test_params)
      redirect_to @test
    else
      render :edit
    end
  end

  def destroy
    @test.destroy
    redirect_to(tests_url)
  end

  def start
    @current_user.start_test(@test)
    redirect_to @current_user.find_test_user(@test)
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def rescue_with_test_not_found
    render plain: I18n.t('controller.tests.not_found')
  end
end
