class Pokey::Hook
  attr_accessor :destination, :http_method, :data, :interval

  def initialize
    @http_method = :post
    @data = {}
  end

  def make_http_request!
    Pokey::Request.make!(destination, http_method, data)
  end
end
