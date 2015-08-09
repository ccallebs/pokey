require "./lib/pokey"

describe Pokey do
  describe "#configure" do
    describe "#hook_dir" do
      it "defaults to app/pokey" do
        Pokey.configure do |config|
        end

        expect(Pokey.hook_dir).to eq("app/pokey")
      end
    end

    describe "#hook_dir=" do
      it "sets value of #hook_dir successfully" do
        Pokey.configure do |config|
          config.hook_dir = "app/new_hook_dir"
        end

        expect(Pokey.hook_dir).to eq("app/new_hook_dir")
      end
    end

    describe "#add_hook" do
      it "increases hook count by 1" do
        expect {
          Pokey.configure do |config|
            config.add_hook do |hook|
              hook.destination = "/endpoint"
              hook.data = {}
              hook.interval = 3600
            end
          end
        }.to change { Pokey::Hooks.count }.by(1)
      end
    end
  end
end
