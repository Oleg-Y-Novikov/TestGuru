# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :find_test, only: %i[show edit update destroy start]
  before_action :find_current_user, only: %i[index start]

  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_test_not_found

  # возвращает коллекцию всех Тестов с дополнительным атрибутом completed(true либо false) модели TestsUser
  # атрибут говорит о полном прохождении Теста текущим пользователем
  def index
    @tests = Test.includes(:category, :questions).select(
      'tests.*, tests_users.completed'
    ).joins(
      "LEFT JOIN tests_users ON tests.id = tests_users.test_id AND tests_users.user_id = #{@current_user.id}"
    )
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    user = User.find(params[:test][:author_id])
    @test = user.tests_author.build(test_params)
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
    if @test.questions.blank?
      flash[:danger] = I18n.t('controller.tests.no_questions_for_test')
      redirect_to root_url
    else
      @current_user.start_test(@test)
      redirect_to @current_user.find_test_user(@test)
    end
  end

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def find_current_user
    @current_user = User.first
  end

  def resque_with_test_not_found
    render plain: I18n.t('controller.tests.not_found')
  end
end
