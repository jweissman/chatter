require 'spec_helper'

describe Bots::Eliza do
  let(:harness) { double(:read => nil) }
  before { subject.use_harness(harness) }

  it 'should reflect your words' do
    subject.set_message("any thing")
    expect(harness).to receive(:write).with("What do you think about thing?")
    subject.converse
  end
end
