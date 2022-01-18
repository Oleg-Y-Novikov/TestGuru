# frozen_string_literal: true

# the class contains the 'app_version' method, which returns the version of the application
class ApplicationVersion
  class << self
    attr_reader :app_version
  end
  @app_version = '0.1.0'
end
