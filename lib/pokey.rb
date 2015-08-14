require "pokey/version"
require "pokey/configuration"
require "pokey/hook"
require "pokey/hooks"
require "pokey/logger"
require "pokey/request"
require "pokey/scheduler"

if defined?(Rails)
  require "generators/rails/install/install_generator"
  require "generators/rails/hook/hook_generator"
end

module Pokey
  class << self
    attr_writer :configuration

    def configure
      yield(configuration)
      Pokey::Scheduler.run! if should_run?
    end

    def configuration
      @configuration ||= Pokey::Configuration.new
    end

    def hook_dir=(val)
      configuration.hook_dir = val
    end
    
    def hook_dir
      configuration.hook_dir
    end

    def should_run?
      current_env.nil? || configuration.run_on.map(&:to_s).include?(current_env)
    end

    def current_env
      if defined?(Rails)
        Rails.env
      end
    end
  end
end
