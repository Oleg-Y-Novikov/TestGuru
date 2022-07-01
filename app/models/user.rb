# frozen_string_literal: true

class User < ApplicationRecord
  # возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь
  def list_all_tests(level)
    join_passed_tests = 'JOIN passed_tests ON tests.id = passed_tests.test_id'
    Test.joins(join_passed_tests).where('tests.level = ? AND passed_tests.user_id = ?', level, id)
  end
end
