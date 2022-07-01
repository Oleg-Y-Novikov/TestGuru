# frozen_string_literal: true

class Test < ApplicationRecord
  # возвращает отсортированный по убыванию массив названий всех Тестов
  # у которых Категория называется определённым образом
  def self.test_title_desc(category_title)
    join_categories = 'JOIN categories ON tests.category_id = categories.id'
    Test.joins(join_categories).where('categories.title LIKE ?', "#{category_title}%").order(title: :desc).pluck(:title)
  end
end
