# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module TestGuru
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.autoload_paths << "#{Rails.root}/lib/clients"
    config.load_defaults 6.1
    config.time_zone = 'Europe/Moscow'
    I18n.load_path += Dir[Rails.root.join("config", "locales", "**", "*.yml")]
    config.available_locales = %i[ru en]
    config.i18n.default_locale = :ru
  end
end
