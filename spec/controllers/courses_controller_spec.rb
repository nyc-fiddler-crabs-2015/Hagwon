# If you don't have anything to test delete it.
require 'rails_helper'

# describe CoursesController do

#   describe 'create new course' do
#     context 'GET/ /courses/new' do

#       before(:each) do
#         get :new
#       end

#       it 'has a form page' do
#         expect(response).to be_ok
#       end

#       it 'renders a form template' do
#         expect(response).to render_template(:new)
#       end
#     end
#   end

#   context "POST /courses" do
#     it 'redirects upon a successful creation' do
#       post :create, { course: {rating: 3, difficuly: 3} }
#       expect(response).to redirect_to('/courses')
#     end
#   end
# end
