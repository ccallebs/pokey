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
      Pokey::Scheduler.run!
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
  end
end
