require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rorla
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.time_zone = 'Seoul'
    config.i18n.default_locale = :ko

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: true,
        request_specs: false
      g.fixture_replacement :factory_girl, dir: "spec/factories"
    end

    # Be sure to have the adapter's gem in your Gemfile
    # and follow the adapter's specific installation
    # and deployment instructions.

    # When enqueuing jobs with the Inline adapter the job will be executed immediately.
    # To use the Inline set the queue_adapter config to :inline.
    # config.active_job.queue_adapter = :inline
    
    config.active_job.queue_adapter = :delayed_job

  end
end
