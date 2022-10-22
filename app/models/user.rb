# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :trackable

  has_many :tests_author, class_name: 'Test', foreign_key: :author_id, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :tests, through: :tests_user, dependent: :destroy

  validates :first_name,  presence: true, length: { maximum: 30 }
  validates :last_name,   presence: true, length: { maximum: 30 }

  before_save :before_save_downcase_email

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

  def admin?
    instance_of?(Admin)
  end

  private

  def before_save_downcase_email
    email.downcase!
  end
end
