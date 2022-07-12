# frozen_string_literal: true

class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true
  validate :validate_quantity_answers, on: :create

  scope :correct_answers, -> { where(correct: true) }

  private

  # проверяет, что у одного Вопроса может быть не более 4-х Ответов
  def validate_quantity_answers
    errors.add(:quantity_answers, I18n.t('model.answer.limit_answers')) if question.answers.count >= 4
  end
end
