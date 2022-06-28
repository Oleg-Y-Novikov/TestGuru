# frozen_string_literal: true

class Test < ApplicationRecord
  belongs_to :category
  has_many :questions
end
