# frozen_string_literal: true

class TestsController < ApplicationController
  before_action :find_test, only: %i[show edit update destroy]
  before_action :find_user, only: %i[create]

  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_test_not_found

  def index
    @tests = Test.includes(:category, :questions).all
  end

  def show; end

  def new
    @test = Test.new
  end

  def create
    @test = @user.tests_author.build(test_params)
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

  private

  def test_params
    params.require(:test).permit(:title, :level, :category_id)
  end

  def find_test
    @test = Test.find(params[:id])
  end

  def find_user
    @user = User.find(params[:test][:author_id])
  end

  def resque_with_test_not_found
    render plain: I18n.t('controller.tests.not_found')
  end
end
