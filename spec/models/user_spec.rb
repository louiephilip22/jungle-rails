require 'rails_helper'

RSpec.describe User, type: :model do

  it "must not be created with different password and password_confirmation" do
    @user = User.create(first_name: 'Philip', last_name: 'Templonuevo', email: 'philip@email.com', password: 'Philip', password_confirmation: 'PhiLip')
    expect(@user.errors.full_messages()).to eq ["Password confirmation doesn't match Password"]
  end

  it "must be created with same password and password_confirmation" do
    @user = User.create(first_name: 'Philip', last_name: 'Templonuevo', email: 'philip@email.com', password: 'Philip', password_confirmation: 'Philip')
    expect(User.find(@user.id)).not_to be_nil
  end

  it "must not be created with a email that have already been saved in DB, even case sensitive" do
    @user1 = User.create(first_name: 'Philip', last_name: 'Templonuevo', email: 'philip@email.com', password: 'Philip', password_confirmation: 'Philip')
    @user2 = User.create(first_name: 'Philip', last_name: 'Louie', email: 'PHILIP@email.com', password: 'Louie', password_confirmation: 'Louie')
    expect(@user2.errors.full_messages()).to eq ["Email has already been taken"]
  end

  it "must not be created without first name" do
    @user = User.create(first_name: nil, last_name: 'Templonuevo', email: 'philip@email.com', password: 'Philip', password_confirmation: 'Philip')
    expect(@user.errors.full_messages()).to eq ["First name can't be blank"]
  end

  it "must not be created without last name" do
    @user = User.create(first_name: 'Philip', last_name: nil, email: 'philip@email.com', password: 'Philip', password_confirmation: 'Philip')
    expect(@user.errors.full_messages()).to eq ["Last name can't be blank"]
  end

  it "must not be created without email" do
    @user = User.create(first_name: 'Philip', last_name: 'Templonuevo', email: nil, password: 'Philip', password_confirmation: 'Philip')
    expect(@user.errors.full_messages()).to eq ["Email can't be blank"]
  end

end
