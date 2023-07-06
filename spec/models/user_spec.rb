require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    it "is valid with first name, last name, email, and passwords" do
      @user = User.new(
        {firstname: "Bastien", 
        lastname: "Moy", 
        email: "bmoy@gmail.com",
        password: "password",
        password_confirmation: "password"
        })
      expect(@user).to be_valid
    end

    it "is not valid without a first name" do
      @user = User.new(
        {firstname: nil, 
        lastname: "Moy", 
        email: "bmoy@gmail.com",
        password: "password",
        password_confirmation: "password"
        })
      expect(@user).to_not be_valid
    end

    it "is not valid without a last name" do
      @user = User.new(
        {firstname: "Bastien", 
        lastname: nil, 
        email: "bmoy@gmail.com",
        password: "password",
        password_confirmation: "password"
        })
      expect(@user).to_not be_valid
    end

    it "is not valid without an email" do
      @user = User.new(
        {firstname: "Bastien", 
        lastname: "Moy", 
        email: nil,
        password: "password",
        password_confirmation: "password"
        })
      expect(@user).to_not be_valid
    end

    it "is not valid when email already exists" do
      @user = User.new(
        {firstname: "Bastien", 
        lastname: "Moy", 
        email: "bmoy@gmail.com",
        password: "password",
        password_confirmation: "password"
        })
      @user.save
      
      @user2 = User.new(
        {firstname: "Felix", 
        lastname: "Moy", 
        email: "bmoy@gmail.com",
        password: "password",
        password_confirmation: "password"
        })
      expect(@user2).to_not be_valid
    end

    it 'is not valid without a password' do
      @user = User.new(
        {firstname: "Bastien", 
        lastname: "Moy", 
        email: "bmoy@gmail.com",
        password: nil,
        password_confirmation: "password"
        })
      expect(@user).to_not be_valid
      end

    it 'is not valid without matching passwords' do
      @user = User.new(
        {firstname: "Bastien", 
        lastname: "Moy", 
        email: "bmoy@gmail.com",
        password: 'password',
        password_confirmation: "passwordd"
        })
      expect(@user).to_not be_valid
      end
     
    it 'is not valid with less than 5 characters' do
      @user = User.new(
        {firstname: "Bastien", 
        lastname: "Moy", 
        email: "bmoy@gmail.com",
        password: 'pass',
        password_confirmation: "pass"
        })
      expect(@user).to_not be_valid
      end 
    end

    describe 'authenticate_with_credentials' do

      it 'returns user if given correct credentials' do
        user = User.create(
          {firstname: "Bastien", 
          lastname: "Moy", 
          email: "bmoy@gmail.com",
          password: 'password',
          password_confirmation: "password"
          })
        result = User.authenticate_with_credentials('bmoy@gmail.com', 'password')
        expect(result).to eq(user)
        end

      it 'returns nil if password is incorrect' do
        @user = User.create(
          {firstname: "Bastien", 
          lastname: "Moy", 
          email: "bmoy@gmail.com",
          password: 'password',
          password_confirmation: "password"
          })
        result = User.authenticate_with_credentials('bmoy@gmail.com', 'pass')
        expect(result).to eq(nil)
        end

      it 'returns user if given additional spaces in email' do
        @user = User.create(
          {firstname: "Bastien", 
          lastname: "Moy", 
          email: "bmoy@gmail.com",
          password: 'password',
          password_confirmation: "password"
          })
        result = User.authenticate_with_credentials(' bmoy@gmail.com ', 'password')
        expect(result).to eq(@user)
        end
      
      it 'returns user if given wrong cases in email' do
        @user = User.create(
          {firstname: "Bastien", 
          lastname: "Moy", 
          email: "bmoy@gmail.com",
          password: 'password',
          password_confirmation: "password"
          })
        result = User.authenticate_with_credentials('bMoy@gmail.com', 'password')
        expect(result).to eq(@user)
        end
    end
end
