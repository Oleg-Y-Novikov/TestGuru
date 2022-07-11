# frozen_string_literal: true

class Test < ApplicationRecord
  # возвращает объект ActiveRecord::Relation с отфильтрованными тестами по уровню сложности
  scope :easy_level,   -> { where(level: 0..1) }
  scope :medium_level, -> { where(level: 2..4) }
  scope :hard_level,   -> { where(level: 4..) }

  # возвращает отсортированный по убыванию массив названий всех Тестов
  # у которых Категория называется определённым образом
  scope :test_title_desc, lambda { |category_title|
                            joins(:category)
                              .where(categories: { title: category_title })
                              .order(title: :desc)
                              .pluck(:title)
                          }

  belongs_to :author, class_name: 'User'
  belongs_to :category

  has_many :questions, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :users, through: :tests_user, dependent: :destroy
end
