require 'spec_helper'

describe Bots::Eliza do
  let(:out) { StringIO.new }
  it 'should reflect your words' do
    out = StringIO.new
    stdin = double
    expect(stdin).to receive(:gets).and_return("any thing\n")
    subject.converse(stdin, out)
    expect(out.string).to eql("What do you think about thing?\n")
  end

  # TODO stock phrases
  # it 'should have some stock Rogerian psychotherapy phrases' do
  #   expect(subject.greet).to eql("Tell me about your dreams\n")
  # end
end
