require 'rails_helper'

describe User do
  it 'is valid with a username and email' do
    user = User.new(
      username: 'Justin',
      email: 'test@example.com')
    expect(user).to be_valid
  end

end