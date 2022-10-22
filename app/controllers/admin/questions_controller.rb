# frozen_string_literal: true

class Admin::QuestionsController < Admin::BaseController
  before_action :find_test, only:     %i[new create]
  before_action :find_question, only: %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_question_not_found

  def show; end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.build(question_params)
    if @question.save
      redirect_to [:admin, @question]
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @question.update(question_params)
      redirect_to [:admin, @question]
    else
      render 'edit'
    end
  end

  def destroy
    @question.destroy
    redirect_to admin_test_url(@question.test)
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def find_question
    @question = Question.find(params[:id])
  end

  def resque_with_question_not_found
    render plain: I18n.t('controller.questions.not_found')
  end
end
