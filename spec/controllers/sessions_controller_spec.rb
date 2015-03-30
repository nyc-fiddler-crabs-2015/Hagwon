require 'rails_helper'

describe SessionsController do

  describe 'create new sessions' do
    context 'GET/ /sessions/new' do

      before(:each) do
        get :new
      end

      it 'has a form page' do
        expect(response).to be_ok
      end

      it 'renders a form template' do
        expect(response).to render_template(:new)
      end
    end
  end

end
