# frozen_string_literal: true

class QuestionsController < ApplicationController
  before_action :find_test, only: [:index, :new, :show, :create, :destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_question_not_found

  def index
    @questions = @test.questions
    respond_to do |format|
      format.html
      format.json { render json: { questions: @questions } }
    end
  end

  def show
    @question = Question.find(params[:id])
    respond_to do |format|
      format.html
      format.json { render json: { question: @question } }
    end
  end

  def new
    @question = Question.new
  end

  def create
    @question = @test.questions.build(question_params)
    if @question.save
      redirect_to @question
    else
      render 'new'
    end
  end

  def destroy
    Question.find(params[:id]).destroy
    redirect_to test_questions_url(@test)
  end

  private

  def question_params
    params.require(:question).permit(:body)
  end

  def find_test
    @test = Test.find(params[:test_id])
  end

  def resque_with_question_not_found
    render plain: I18n.t('controller.questions.not_found')
  end
end
