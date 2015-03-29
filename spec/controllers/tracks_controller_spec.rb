require 'rails_helper'

describe TracksController do
  let!(:user){User.create(email: 'rayanbouts@gmail.com', username: 'rayanbouts', password: 'ilovejs')}
  let!(:category){Category.create(name: 'Programming')}
  let!(:track){Track.create(name: 'Learn python in no time', owner: user, category: category)}
  let!(:course){Course.create(name: 'Vim', url: 'http://vim.com', category: category)}

  before do
    session[:user_id] = user.id
  end

  it 'has an index page' do
    get :index
    expect(response).to be_ok
  end

  it 'has a show page' do
    tracks_path(track.id)
    expect(response).to be_ok
  end

  it 'has a "form" page that lets you create a track' do
    new_category_track_path(category.id)
    expect(response).to be_ok
  end

  it 'creates a track with courses' do
    post :create, {:category_id => category.id, title:'Super track', 'course'=>{course.id=>course.id} }
    expect(CourseTrack.last.course_id).to eq(course.id)
  end

end
