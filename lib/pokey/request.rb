# Handles making the request to the webhook destination

require 'net/http'

class Pokey::Request
  attr_accessor :destination, :http_method, :data

  def initialize(destination, http_method = :post, data = {})
    @destination, @http_method, @data = destination, http_method, data
  end

  def raw_request
    http_object
  end

  def make!
    Net::HTTP.start(uri.host, uri.port) do |http|
      request = raw_request

      if request.is_a?(Net::HTTP::Post)
        request.set_form_data(@data)
      end

      response = http.request(request)
    end 
  end

  def uri
    raw_uri = URI.parse(@destination)
    
    if @http_method == :get
      raw_uri.query = URI.encode_www_form(@data)
    end

    raw_uri
  end

  def self.make!(destination, http_method, data)
    request = Pokey::Request.new(destination, http_method, data)
    request.make!
    request
  end

  private

  def http_object
    @http_object ||= begin
      if @http_method == :get
        Net::HTTP::Get.new(uri)
      elsif @http_method == :post
        Net::HTTP::Post.new(uri)
      else
        raise UnknownHTTPObjectError
      end
    end
  end
end

class UnknownHTTPObjectError < Exception; end;
