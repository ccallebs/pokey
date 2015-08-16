require './lib/pokey'

RSpec.describe Pokey::Hook do
  subject { Pokey::Hook.new }

  describe "#initialize" do
    it "defaults #http_method to :post" do
      expect(subject.http_method).to eq :post
    end

    it "defaults #data to empty hash" do
      expect(subject.data).to eq({})
    end
  end

  context "when subclassed" do
    subject do
      class TestHook < Pokey::Hook
        def destination
          "/test/hook"
        end

        def http_method
          :get
        end

        def data
          {
            name: "Test Hook",
            id: 1
          }
        end 
      end

      TestHook.new
    end

    it "uses overridden parameters instead of default values" do
      expect(subject.http_method).to eq(:get)
      expect(subject.data).to eq({ name: "Test Hook", id: 1 })
    end

    describe '#make_http_request!' do
      it 'attempts to make an http request' do
        expect(Pokey::Request).to receive(:make!)
        subject.make_http_request!
      end
    end
  end
end

