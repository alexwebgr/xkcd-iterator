require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module XkcdIteratorV2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    app_env = YAML.safe_load(File.open('config/application.yml'))
    app_env.fetch(Rails.env, {}).each do |key, value|
      if value.kind_of? Hash
        value.each do |keyI, valueI|
          ENV["#{key}_#{keyI}"] = valueI.to_s
        end
      else
        ENV[key] = value.to_s
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
