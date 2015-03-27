require 'rails_helper'

describe CategoriesController do
  it 'has an index page' do
    get :index
    expect(response).to be_ok
  end
end