# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :authenticate_user
end
