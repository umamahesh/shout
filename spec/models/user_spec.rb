require 'rails_helper'

RSpec.describe User, type: :model do
  
  
  before do 
    user_params = {
      #:first_name => "FirstName",
      #:last_name => "LastName",
      :email => 'test_user@example.com',
      :password => 'password',
      :password_confirmation => "password"
    }
    @user = User.new(user_params)
  end
  
  describe "user role" do
    it "defaults to client" do
      @user.valid?
      expect(@user.role).to eq('client')
    end
    
    it "may be assigned client role" do
      @user.role = :client
      expect(@user.role).to eq('client')
    end
    
    it "may be assigned admin role" do
      @user.role = :admin
      expect(@user.role).to eq('admin')
    end
    
    it "may not be assigned nonexistent role" do
      @user.role = :test_role
      @user.should_not be_valid
    end
  end
  
  describe "abilities" do
    
    before do 
      @message = FactoryGirl.build(:message)
      @message.recipient= mock_model("User")
    end
    describe "as a unsaved user" do
      let(:user) { FactoryGirl.build(:user, :role=>'client') }
      subject(:ability) { Ability.new(user) }
      #it { should_not be_able_to :read, @message }
    end
    
    describe "as a saved user" do
      let(:user) { FactoryGirl.create(:user, :role=>'client') }
      
      subject(:ability) { Ability.new(user) }
      #it { should be_able_to :read, @message }
    end
    
    
    describe "as a staff user" do
      let(:user) { FactoryGirl.create(:user, :role=>'staff') }
      subject(:ability) { Ability.new(user) }
      #it { should be_able_to :create, Message.new(:recipient=>user) }
    end
  end
  
  
  describe "email validation" do
    describe "when email is valid" do
      it "" do
        @user.email = "me@example.com"
        expect(@user.valid?).to eq(true)
        expect(@user).to have(0).error_on(:email)
      end
    end
    
    
    describe "when email is not valid" do
      it "" do
        @user.email = "me@"
        @user.valid?.should == false
        expect(@user).to have(1).error_on(:email)
        @user.errors[:email].should == ["is invalid"]
      end
    end
  end
  
   describe "lock_access!" do
     
    it "should send notificaiton" do
      mailer = double(:mailer)
      expect(mailer).to receive(:deliver)
      #mailer.should_receive(:deliver)
      expect(UserMailer).to receive(:account_locked).with(@user).and_return(mailer) 
      #UserMailer.should_receive(:account_locked).with(@user).and_return(mailer)      
      @user.lock_access!
    end
    
    it "should lock the user account" do
      @user.lock_access!
      expect(@user.locked_at).to_not be_nil
    end
    
    it "should set the last locked at time on the account" do
      now = Time.now
      Time.stub(:now).and_return(now)
      @user.lock_access!
      expect(@user.last_locked_at).to eq(now)
    end
  end
  
  
  
  
  
  
  
  
  
  
  
end
