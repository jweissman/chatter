require 'spec_helper'
require 'chatter'

describe Chatter do
  it "should have a VERSION constant" do
    subject.const_get('VERSION').should_not be_empty
  end

  it 'should have a working executable' do
    run_interactive "chatter"
    type 'bye!'
    assert_exit_status(0)
  end
end
