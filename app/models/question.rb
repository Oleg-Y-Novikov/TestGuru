# frozen_string_literal: true

class Question < ApplicationRecord
  belongs_to :test

  has_many :tests_user, foreign_key: :current_question, dependent: :destroy
  has_many :answers, dependent: :destroy

  validates :body, presence: { message: I18n.t('model.cant_be_blank') }
end
