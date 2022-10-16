# frozen_string_literal: true

class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i.freeze

  has_many :tests_author, class_name: 'Test', foreign_key: :author_id, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :tests, through: :tests_user, dependent: :destroy

  validates :name,  presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }

  before_save :before_save_downcase_email

  has_secure_password

  # возвращает список всех Тестов, которые проходит или когда-либо проходил Пользователь фильтруя по сложности
  def list_all_tests(level)
    tests.where(level: level)
  end

  def tests_passed
    tests.where(tests_users: { completed: true })
  end

  # метод реализут логику начала прохождения конкретного теста
  def start_test(test)
    test_user = find_test_user(test)
    return if test_user.present?

    tests.push(test)
  end

  # возвращает объект TestsUser который связан с текущим User-ом и с переданным Test-ом
  def find_test_user(test)
    tests_user.find_by(test_id: test.id)
  end

  private

  def before_save_downcase_email
    email.downcase!
  end
end
