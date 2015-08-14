require "pokey/version"
require "pokey/configuration"
require "pokey/hook"
require "pokey/hooks"
require "pokey/logger"
require "pokey/request"
require "pokey/scheduler"

if defined?(Rails)
  require "generators/install/install_generator"
end

module Pokey
  class << self
    attr_writer :configuration

    def configure
      yield(configuration)
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
