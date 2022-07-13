# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category

  has_many :questions, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :users, through: :tests_user, dependent: :destroy

  validates :title, presence: true
  validates_numericality_of :level, only_integer: true, greater_than_or_equal_to: 0
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
end
