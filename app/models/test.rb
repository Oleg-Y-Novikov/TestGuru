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
    join_categories = 'JOIN categories ON tests.category_id = categories.id'
    joins(join_categories).where(
      'categories.title LIKE :title', title: "#{Category.sanitize_sql_like(category_title)}%"
    ).order(title: :desc).pluck(:title)
  end
end
