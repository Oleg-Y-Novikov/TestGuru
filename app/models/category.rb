# frozen_string_literal: true

class Category < ApplicationRecord
  default_scope { order(:title) }

  has_many :tests, dependent: :destroy
end
