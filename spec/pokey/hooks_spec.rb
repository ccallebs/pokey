require './lib/pokey/hook'
require './lib/pokey/hooks'

RSpec.describe Pokey::Hooks do
  before do
    Pokey::Hooks.clear!
  end

  describe '.add' do
    subject do
      Pokey::Hooks.add do |hook|
        hook.destination = "http://test.com/destination"
      	hook.data = {
      	  name: "Test",
      	  id: 1
      	}
      	hook.interval = 3600
      end
    end

    it 'succesfully adds hook to list' do
      expect { subject }.to change { Pokey::Hooks.all.length }.by(1) 
    end

    it 'successfully retains hook data' do
      subject
      hook = Pokey::Hooks.all.first
      expect(hook.destination).to eq("http://test.com/destination")
      expect(hook.data).to eq({ name: "Test", id: 1 })
      expect(hook.interval).to eq(3600)
    end

    context 'when destination is bad' do
      subject do
        Pokey::Hooks.add do |hook|
          hook.interval = 3600
        end
      end

      it 'throws exceptions' do
        expect { subject }.to raise_error(Pokey::InvalidDestinationError)
      end
    end

    context 'when interval is bad' do
      subject do
        Pokey::Hooks.add do |hook|
          hook.destination = "http://test.com/destination"
        end
      end

      it 'raises exception' do
        expect { subject }.to raise_error(Pokey::InvalidIntervalError)
      end
    end

    context 'when http_method is bad' do
      subject do
        Pokey::Hooks.add do |hook|
          hook.destination = "http://test.com/destination"
          hook.http_method = :does_not_exist
        end
      end

      it 'raises exception' do
        expect { subject }.to raise_error(Pokey::InvalidHTTPMethodError)
      end
    end
  end

  describe '.add_from_dir' do
    let(:dir) { './spec/pokey/sample_hooks/' }

    let(:subject) do
      Pokey::Hooks.add_from_dir(dir)
    end
    
    it 'has multiple files in the directory' do
      expect(Dir.entries(dir).size).to be > 1
    end

    it 'successfully adds multiple hooks' do
      Pokey::Hooks.clear!
      count = Dir.entries(dir).size - 2
      subject
      expect(Pokey::Hooks.all.length).to eq(count)
    end
  end
end
