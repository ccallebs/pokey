require './lib/pokey'

RSpec.describe Pokey::Hook do
  subject { Pokey::Hook.new }

  context "when subclassed" do
    subject do
      class TestHook < Pokey::Hook
        def destination
          "/test/hook"
        end

        def http_method
          :post
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

    context '#make_http_request!' do
      it 'attempts to make an http request' do
        expect(Pokey::Request).to receive(:make!)
        subject.make_http_request!
      end
    end
  end
end

