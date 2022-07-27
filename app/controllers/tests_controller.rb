# frozen_string_literal: true

class TestsController < ApplicationController
  def index
    @tests = Test.includes(:category, :questions).all
  end
end
