require 'spec_helper'

class Sample < Bot
  def parse(input)
    if input =~ /hi/
      @response = 'Hi'
    elsif input =~ /movies/
      @response = 'Movies are cool'
    elsif input =~ /bye/
      @response = 'Bye'
      @active = false
    else 
      @response = 'what? :('
    end
  end
end

describe Bot do
  subject { Sample.new }

  it 'should match a configured pattern' do
    stdin = double
    out = StringIO.new
    expect(stdin).to receive(:gets).and_return("well hi there\n")
    subject.converse(stdin,out)
    expect(out.string).to eql("Hi\n")
  end

  let(:script) do
    [
      { hear: "hi there",      say: "Hi" },
      { hear: "i like movies", say: "Movies are cool" },
      { hear: "well bye",      say: "Bye" }
    ]
  end

  it 'should converse interactively' do
    stdin = double
    script.each do |line|
      out = StringIO.new
      expect(stdin).to receive(:gets).and_return(line[:hear])
      subject.converse(stdin, out)
      expect(out.string.chomp).to eql(line[:say])
    end
  end

  it 'should say goodbye' do
    out = StringIO.new
    stdin = double(:gets => "well bye there\n")
    subject.converse(stdin,out)
    expect(out.string).to eql("Bye\n")
  end
 
  # kind of an integration test, hopefully to be supplemented with aruba?
  it 'should greet you, initiate interactivity and bid goodbye' do
    out = StringIO.new
    stdin = double
    expect(stdin).to receive(:gets).and_return("goodbye\n")
    subject.converse!(stdin, out)
    expect(out.string).to eql("Hello\nBye\n")
  end
end
