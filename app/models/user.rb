# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tests_author, class_name: 'Test', foreign_key: :author_id, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :tests, through: :tests_user, dependent: :destroy

  # возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь
  def list_all_tests(level)
    join_tests_users = 'JOIN tests_users ON tests.id = tests_users.test_id'
    Test.joins(join_tests_users).where(tests_users: { user_id: id }).where(tests: { level: level })
  end
end
