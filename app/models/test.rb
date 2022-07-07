# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :category

  has_many :questions, dependent: :destroy
  has_many :tests_user, dependent: :destroy
  has_many :users, through: :tests_user, dependent: :destroy

  # возвращает отсортированный по убыванию массив названий всех Тестов
  # у которых Категория называется определённым образом
  def self.test_title_desc(category_title)
    joins(:category)
      .where(categories: { title: category_title })
      .order(title: :desc)
      .pluck(:title)
  end
end
