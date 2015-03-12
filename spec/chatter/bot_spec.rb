require 'spec_helper'

class Sample < Bot
  def parse(input)
    if input =~ /hi/
      @response = 'Hi'
    elsif input =~ /movies/
      @response = 'Movies are cool'
    elsif input =~ /bye/
      deactivate
      @response = 'Bye'
    else 
      @response = 'what?'
    end
  end
end

describe Bot do
  let(:harness) { double(:read => nil) }
  subject { Sample.new }
  before { subject.use_harness(harness) }

  it 'should match a configured pattern' do
    message, reply = "well hi there", "Hi"
    subject.set_message(message)
    expect(harness).to receive(:write).with(reply)

    subject.converse   
  end

  let(:script) do
    [
      { hear: "hi there",      say: "Hi" },
      { hear: "i like movies", say: "Movies are cool" },
      { hear: "well bye",      say: "Bye" }
    ]
  end

  it 'should converse interactively' do
    script.each do |line|
      message, reply = line[:hear], line[:say]
      subject.set_message(message)
      expect(harness).to receive(:write).with(reply)
      subject.converse
    end
  end

  it 'should say goodbye' do
    message, reply = "well bye", "Bye"
    subject.set_message(message)
    expect(harness).to receive(:write).with(reply)
    subject.converse
  end
 
  it 'should greet you, initiate interactivity and bid goodbye' do
    message = "well bye"
    subject.set_message(message)
    expect(harness).to receive(:write).with("Hello!")
    expect(harness).to receive(:write).with("Bye")
    subject.converse! 
  end
end
