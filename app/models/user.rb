# frozen_string_literal: true

class User < ApplicationRecord
  # возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь
  def list_all_tests(level)
    join_users_tests = 'JOIN users_tests ON tests.id = users_tests.test_id'
    Test.joins(join_users_tests).where(users_tests: { user_id: id }).where(tests: { level: level })
  end
end
