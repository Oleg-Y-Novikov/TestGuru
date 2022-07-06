# frozen_string_literal: true

class TestsUser < ApplicationRecord
  belongs_to :test
  belongs_to :user
end
