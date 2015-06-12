require 'rails_helper'

RSpec.describe Message, type: :model do
  
  before(:each) do 
    #@message = Message.new(title: 'message', text: "sample text", recipient: mock_model("User"))
    @message = FactoryGirl.build(:message)
    @message.recipient= mock_model("User")
  end
  
  it "is valid with valid attributes" do 
    expect(@message).to be_valid
  end
  
  it "should not have errors with valid attributes" do 
    expect(@message).to have(0).error_on(:text)
  end
  
  it "is not valid without a title" do 
    @message.title = nil
    expect(@message).not_to be_valid 
  end
  
  it "should have error message for title when no title was given" do
    @message.title = nil
    expect(@message).to have(1).error_on(:title)
  end
  
  
  it "is not valid without text" do 
    @message.text = nil
    expect(@message).not_to be_valid   
  end
  
  it "should have error message for text when no text was given" do
    @message.text = nil
    expect(@message).to have(1).error_on(:text)
  end
  
  
  it "is not valid without a recipient" do 
    @message.recipient = nil
    expect(@message).not_to be_valid 
  end
  
  it "should have error message for recipient when no recipient was given" do
    @message.recipient = nil
    expect(@message).to have(1).error_on(:recipient)
  end
end
