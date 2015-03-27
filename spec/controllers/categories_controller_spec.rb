require 'rails_helper'

describe CategoriesController do
  let!(:category){Category.create(name: 'Programming')}

  it 'has an index page' do
    get :index
    expect(response).to be_ok
  end

  it 'has a show page for a specific category' do
    category_path(category.id)
    expect(response).to be_ok
  end

end