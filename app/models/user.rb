# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tests_author, class_name: 'Test', foreign_key: :author_id, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :tests, through: :tests_user, dependent: :destroy

  # возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь фильтруя по сложности
  def list_all_tests(level)
    tests.where(level: level)
  end
end
