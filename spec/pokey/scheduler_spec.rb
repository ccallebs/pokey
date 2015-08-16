require './lib/pokey'

RSpec.describe Pokey::Scheduler do
  before(:all) do
    Pokey.configure do |config|
      config.hook_dir = "spec/sample_hooks"

      config.add_hook do |hook|
        hook.destination = "/my/webhook/endpoint"
        hook.interval = 5
      end
    end
  end

  before do
    allow_any_instance_of(Pokey::Hook).to receive(:make_http_request!).and_return(true)
  end

  describe "#run!" do
    it "adds hooks from specified directory" do
      expect(Pokey::Hooks).to receive(:add_from_dir).with(Pokey.hook_dir)
      Pokey::Scheduler.run!
    end

    it "includes hooks from both the initializer and hook_dir" do
      expect(Pokey::Hooks.count).to eq(3)
    end
  end
end
