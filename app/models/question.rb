# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  has_many :answers, dependent: :destroy

  validates :body, presence: true
  validate :validate_quantity_answers

  private

  # проверяет, что у одного Вопроса может быть не менее 1-го и не более 4-х ответов
  def validate_quantity_answers
    errors.add(:quantity_answers, 'question should have from 1 to 4 answers') unless (1..4).include? answers.size
  end
end
