class Pokey::Hook
  attr_accessor :destination, :http_method, :data, :interval

  def initialize
    @http_method = :post
    @data = {}
  end

  def make_http_request!
    Pokey::Request.make!(destination, http_method, data)
  end

  def valid?
    validate_http_method!
    validate_interval!
    validate_destination!
    true
  end

  private

  def validate_http_method!
    raise Pokey::InvalidHTTPMethodError unless [:get, :post].include?(@http_method)
  end

  def validate_destination!
    raise Pokey::InvalidDestinationError if destination.nil? || destination == ""
  end

  def validate_interval!
    raise Pokey::InvalidIntervalError if @interval.nil? || @interval.zero?
  end
end

class Pokey::InvalidHTTPMethodError < Exception; end;
class Pokey::InvalidDestinationError < Exception; end;
class Pokey::InvalidIntervalError < Exception; end;
