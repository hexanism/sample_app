# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'spec_helper'

describe User do
  # Create a user to use in the tests...
  before { @user = User.new(name:"Example User", email: "user@example.com",
                          password: 'foobar', password_confirmation: 'foobar') }
  # ...and set it as the subject.
  subject { @user }

  # The user should behave like a user object should.
  it { should respond_to(:name) }
  it { should respond_to(:email) }
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }
  it { should respond_to(:remember_token) }

  it { should be_valid }

  # Tests for validating presence of necessary attributes...
  describe "when name is not present" do
    # I don't understand why this needs to be in a
    # before block but it does.
    # If the line is just '@user.name = ""'
    # the test suite throws an error: undefined method
    # name= for nil object.
    before { @user.name = "" }
    it { should_not be_valid }
  end

  describe "when email is not present" do
    before { @user.email = "" }
    it { should_not be_valid }
  end

  describe "when password is not present" do
    before { @user.password = @user.password_confirmation = "" }
    it { should_not be_valid }
  end

  # --------------------------------------------------------------------------
  # Test that name is valid...
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  # --------------------------------------------------------------------------
  # Test that email is valid...
  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email.upcase!
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

  # --------------------------------------------------------------------------
  # Test validity of passwords
  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = 'mismatch' }
    it { should_not be_valid }
  end

  # The password confirmation can only be nil through
  # the console, but we still add a test.
  # It is strange that this case slips through the other
  # tests. M.Hartl thinks this is a rails bug.
  # Perhaps it will be fixed in a new version.
  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = 'a' * 5 }
    it { should be_invalid }
  end

  # These tests will attempt to retrieve a user from
  # the database using both a valid and invalid password.
  describe "return value of authenticate method" do
    # Save the original user to the db so we can search for it.
    before { @user.save }
    # This let will be the same as @user (I think)
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

  # Test the downcasing of a saved password.
  describe "email address with mixed case" do
    let(:mixed_case_email) { "Foo@ExAmPlE.CoM" }

    it "should be saved as all lowercase" do
      @user.email = mixed_case_email
      @user.save
      @user.reload.email.should == mixed_case_email.downcase
    end
  end

  # When a user is saved it should have a remember token.
  describe "remember token" do
    before { @user.save }
    its(:remember_token) { should_not be_blank }
  end
end