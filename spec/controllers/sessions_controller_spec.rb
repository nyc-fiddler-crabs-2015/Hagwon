require 'rails_helper'


describe SessionsController do

  describe "GET /sessions/new" do
    it "renders user sign in form" do
      get :new
      expect(response).to be_ok
    end
  end

end
