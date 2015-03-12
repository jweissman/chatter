require 'spec_helper'

describe Bots::Clever do
  let(:harness) { double(read: nil) }
  before { subject.use_harness(harness) }

  it 'should respond to a prompt' do
    subject.send(:remember, "hello", "hi")

    subject.set_message("hi")
    expect(harness).to receive(:write).with("hello")
    subject.converse
  end

  it 'should remember multiple things for a given prompt' do
    msg = "hi"
    subject.send(:remember,"hello", msg)
    subject.send(:remember,"hey", msg)
    expect(subject.send(:memories_for,msg)).to eql(["hello", "hey"])
  end

  let(:out) { StringIO.new }
  it 'should remember your words' do
    expect(harness).to receive(:write).with(Default.greeting)
    subject.greet

    subject.set_message("hello there")    # train a response to greeting
    expect(harness).to receive(:write)    
    subject.converse

    subject.set_message(Default.greeting) # prompt with greeting
    expect(harness).to receive(:write).with("hello there")
    subject.converse
  end

  it 'should keep track between invocations' do
    subject.send(:remember,"something", "good")
    subject.send(:dump_memory)
    subject.send(:clear_memory)
    subject.send(:load_memory)
    expect(subject.send(:memories_for,"good")).to eql(["something"])
  end
end
