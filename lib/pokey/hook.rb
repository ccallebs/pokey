class Pokey::Hook
  attr_accessor :destination, :http_method, :data, :interval

  def make_http_request!
    Pokey::Request.make!(destination, http_method, data)
  end
end
