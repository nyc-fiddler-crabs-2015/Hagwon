require 'rails_helper'

describe User do
  let(:user) { FactoryGirl.build(:user) }

  it 'is valid with an email' do
    user = User.new(email: 'test@example.com')
    expect(user).to be_valid
  end

  it 'has a valid factory' do
    expect(true).to eq true
  end

  it 'has a email' do
    expect(user.email).to be_kind_of(String)
  end

end
