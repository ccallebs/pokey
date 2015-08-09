require './lib/pokey/request'

RSpec.describe Pokey::Request do
  let(:destination) { "http://test.com/test/endpoint" }
  let(:http_method) { :post }
  let(:data)        { { name: "Test Endpoint", id: 1 } }

  describe 'defaults' do
    subject { Pokey::Request.new(destination) }

    it 'defaults http_method to post' do
      expect(subject.http_method).to eq(:post)
    end

    it 'defaults data to {}' do
      expect(subject.data).to eq({})
    end
  end

  describe "#make!" do
    subject { Pokey::Request.make!(destination, http_method, data) }

    context 'when :post' do
      before(:each) do
        stub_request(:post, destination)
      end

      it "successfully makes http request" do
        expect(Net::HTTP::Post).to receive(:new)
        expect_any_instance_of(Net::HTTP).to receive(:request)
        subject
      end

      it "passes params along with it" do
        expect_any_instance_of(Net::HTTP::Post).to receive(:set_form_data).with(data)
        subject
      end
    end

    context 'when :get' do
      let(:http_method) { :get }

      it "successfully makes http request" do
        expect(Net::HTTP::Get).to receive(:new)
        expect_any_instance_of(Net::HTTP).to receive(:request)
        subject
      end

      it "passes params in the uri" do
        request = Pokey::Request.new(destination, http_method, data)
        expect(request.uri.to_s.length).to be > destination.length  
      end
    end
  end
end
