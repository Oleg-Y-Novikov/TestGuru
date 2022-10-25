# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category

  has_many :questions, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :users, through: :tests_user, dependent: :destroy

  validates :title, presence: { message: I18n.t('model.cant_be_blank') }
  validates :level, numericality: { only_integer: true,
                                    greater_than_or_equal_to: 0,
                                    message: I18n.t('model.only_integer') }
  validates :title, uniqueness: { scope: :level,
                                  case_sensitive: false,
                                  message: I18n.t('model.test.test_exists') }

  # возвращает объект ActiveRecord::Relation с отфильтрованными тестами по уровню сложности
  scope :easy_level,   -> { where(level: 0..1) }
  scope :medium_level, -> { where(level: 2..4) }
  scope :hard_level,   -> { where(level: 4..) }

  # возвращает объект ActiveRecord::Relation с отсортированными по убыванию объектами Тестов
  # у которых Категория называется определённым образом
  scope :test_title_desc, lambda { |category_title|
                            joins(:category)
                              .where(categories: { title: category_title })
                              .order(title: :desc)
                          }

  # возвращает отсортированный по убыванию массив названий всех Тестов
  # у которых Категория называется определённым образом
  def self.array_test_title_desc(category_title)
    test_title_desc(category_title).pluck(:title)
  end

  def self.show_tests_for_current_user(current_user)
    includes(:category).select(
      'tests.*, tests_users.completed, COUNT(questions.id) AS count_questions'
    ).joins(:questions).joins(
      "LEFT JOIN tests_users ON tests.id = tests_users.test_id AND tests_users.user_id = #{current_user.id}"
    ).group('tests.id')
  end
end
