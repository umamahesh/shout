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
  
  
  
   describe "email validation" do
    describe "when email is valid" do
      it "" do
        @user.email = "me@example.com"
        expect(@user.valid?).to be_true
        expect(@user.errors[:email]).to eq([])
      end
    end
    describe "when email is not valid" do
      it "" do
        @user.email = "me@"
        @user.valid?.should == false
        @user.errors[:email].should == ["is invalid"]
      end
    end
  end
end
