require './lib/pokey'

RSpec.describe Pokey::Scheduler do
  before do
    Pokey.add_hook do |hook|
      hook.destination = "/my/webhook/endpoint"
    end
  end
end
