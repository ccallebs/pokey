require 'logging'

Logging.logger.root.appenders = Logging.appenders.stdout
Logging.logger.root.level = :info

class Pokey::Logger
  attr_reader :log

  def initialize
    @log = Logging.logger[self]
  end
end
