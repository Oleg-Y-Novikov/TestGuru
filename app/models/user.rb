# frozen_string_literal: true

class User < ApplicationRecord
  has_many :tests_author, class_name: 'Test', foreign_key: :author_id, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :tests, through: :tests_user, dependent: :destroy

  validates :name, presence: true
  validates :email, presence: true

  # возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь фильтруя по сложности
  def list_all_tests(level)
    tests.where(level: level)
  end

  # метод реализут логику начала прохождения конкретного теста
  def start_test(test)
    test_passege = tests_user.find_by(test_id: test.id)
    return if test_passege.present?

    tests.push(test)
  end

  def test_completed?(test)
    return unless find_test_user(test)

    find_test_user(test).completed?
  end

  # возвращает объект TestsUser который связан с текущим User-ом и с переданным Test-ом
  def find_test_user(test)
    tests_user.find { |obj| obj.test_id == test.id }
  end
end
