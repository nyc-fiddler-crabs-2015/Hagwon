require 'spec_helper'
require 'pp'

describe SessionsController do

  describe "GET /sessions/new" do
    it "renders user sign in form" do
      new_session_path
      expect(response).to be_ok
    end
  end

end