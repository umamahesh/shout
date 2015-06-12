require 'rails_helper'

#expect(foo).to receive(:bar)
#expect(foo).to receive(:bar).with(:buzz)
#expect(foo).to receive(:bar).exactly(3).times


RSpec.describe MessagesController, type: :controller do
  
  before do
    @message = FactoryGirl.build(:message)
    @message.recipient= mock_model("User")
    @message.save
  end
  
  
  describe "List all messages" do 
    subject { get :index }    
    
    it "assigns all messages as @messages" do 
      message = @message
      subject
      expect(response.status).to eq(200)
      expect(assigns(:messages)).to eq(message)
    end
    
    it "renders the index template" do
      expect(subject).to render_template("index")
    end   
    
   end
  

end
