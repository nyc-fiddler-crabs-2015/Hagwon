require 'rails_helper'

describe TracksController do
  let!(:user){User.create(email: 'rayanbouts@gmail.com', username: 'rayanbouts', password: 'ilovejs')}
  let!(:category){Category.create(name: 'Programming')}
  let!(:track){Track.create(name: 'Learn python in no time', user: user, category: category)}

  it 'has an index page' do
    get :index
    expect(response).to be_ok
  end

end