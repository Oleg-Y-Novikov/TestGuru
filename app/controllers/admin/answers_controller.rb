# frozen_string_literal: true

class Admin::AnswersController < Admin::BaseController
  before_action :find_question, only: %i[new create]
  before_action :find_answer, only:   %i[show edit update destroy]

  rescue_from ActiveRecord::RecordNotFound, with: :resque_with_answer_not_found

  def show; end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.build(answer_params)
    if @answer.save
      redirect_to [:admin, @answer]
    else
      render :new
    end
  end

  def edit; end

  def update
    if @answer.update(answer_params)
      redirect_to [:admin, @answer]
    else
      render :edit
    end
  end

  def destroy
    @answer.destroy
    redirect_to admin_question_url(@answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body, :correct)
  end

  def find_question
    @question = Question.find(params[:question_id])
  end

  def find_answer
    @answer = Answer.find(params[:id])
  end

  def resque_with_answer_not_found
    render plain: I18n.t('controller.answers.not_found')
  end
end
