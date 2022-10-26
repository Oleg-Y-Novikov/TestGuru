# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_quantity_answers, on: :create

  scope :correct, -> { where(correct: true) }

  private

  # проверяет, что у одного Вопроса может быть не более 4-х Ответов
  def validate_quantity_answers
    return if question.answers.count < 4

    errors.add(:quantity_answers, I18n.t(:quantity_answers, scope: [:activerecord, :errors,
                                                                    :models, :answer, :messages]))
  end
end
