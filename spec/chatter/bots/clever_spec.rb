require 'spec_helper'

describe Bots::Clever do
  it 'should respond to a prompt' do
    subject.remember("hello", "hi")
    expect(subject.response_to("hi")).to eql("hello")
  end

  it 'should remember multiple things for a given prompt' do
    msg = "hi"
    subject.remember("hello", msg)
    subject.remember("hey", msg)
    expect(subject.memories_for(msg)).to eql(["hello", "hey"])
  end

  let(:out) { StringIO.new }
  it 'should remember your words' do
    out = StringIO.new
    stdin = double

    expect(stdin).to receive(:gets).and_return(
      "hello there",     # train
      Default.greeting,  # prompt
      "goodbye"          # stop
    )

    subject.converse!(stdin,out)

    expect(out.string.split("\n")[2]).to eql( "hello there" ) # trained response
  end

  it 'should keep track between invocations' do
    subject.remember("something", "good")
    subject.send(:dump_memory)
    subject.clear_memory
    subject.send(:load_memory)
    expect(subject.memories_for("good")).to eql(["something"])
  end
end
