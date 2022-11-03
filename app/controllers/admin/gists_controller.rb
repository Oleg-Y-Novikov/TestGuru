# frozen_string_literal: true

class Admin::GistsController < Admin::BaseController
  def index
    @gists = Gist.includes(:user, :question)
  end
end
