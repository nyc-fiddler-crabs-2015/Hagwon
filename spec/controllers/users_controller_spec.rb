require 'rails_helper'

describe UsersController do

  let(:user) {User.create(username: "dongchul", email: "i-love-ruby@gmail.com", password: "1234")}

  describe "GET /users/new " do
    it "loads user creation form" do
      new_user_path
      expect(response).to be_ok
    end
  end

end

