require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should create a new user' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "passedword",  :password_confirmation => "passedword")
      assert @user.save!
    end

    it 'shouldnt create a new user when the passwords do not match' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "passedword",  :password_confirmation => "passwod")
      assert !@user.save
      assert @user.errors.full_messages.include? "Password confirmation doesn't match Password"
    end

    it 'shouldnt create a new user when the password field is blank' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "", :password_confirmation   => "")
      assert !@user.save
      assert @user.errors.full_messages.include? "Password can't be blank"
    end

    it 'should have a minimum password length of 5' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "1234",  :password_confirmation => "1234")
      assert !@user.save
      assert @user.errors.full_messages.include? "Password is too short (minimum is 5 characters)"
    end

    it 'should not allow the same email to create another account' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "123456",  :password_confirmation => "123456")
      @user.save!
      @user2 = User.new(:email => 'jimmy@jimmy.com', :password => "123456",   :password_confirmation => "123456")
      assert !@user2.save
      assert @user2.errors.full_messages.include? "Email has already been taken"
    end

    it 'should not allow the same email to create another account' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "123456",  :password_confirmation => "123456")
      @user.save!
      @user2 = User.new(:email => 'JIMMY@jimmy.com', :password => "123456",   :password_confirmation => "123456")
      assert !@user2.save
      assert @user2.errors.full_messages.include? "Email has already been taken"
    end

  end

  describe '.authenticate_with_credentials' do
    it 'prevent the wrong password from being entered' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "123456",  :password_confirmation => "123456")
      @user.save!
      assert @user.authenticate_with_credentials('jimmy@jimmy.com', "12345666") == nil
    end

    it 'prevent the wrong password from being entered' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "123456",  :password_confirmation => "123456")
      @user.save!
      assert @user.authenticate_with_credentials('jimmy@jimmy.com', "123456") == @user
    end
    it 'should allow for extra space' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "123456",  :password_confirmation => "123456")
      @user.save!
      assert @user.authenticate_with_credentials('   jimmy@jimmy.com', "123456") == @user
    end
    it 'should allow for different characters' do
      @user = User.new(:email => 'jimmy@jimmy.com', :password => "123456",  :password_confirmation => "123456")
      @user.save!
      assert @user.authenticate_with_credentials('jiMMy@jimmy.com', "123456") == @user
    end
  end

end
