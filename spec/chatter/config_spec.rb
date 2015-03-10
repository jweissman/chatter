require 'spec_helper'

describe Chatter::Config do
  it 'should specify a default robot' do
    expect(Chatter::Default.bot).to be_an(Bots::Clever)
  end
end
