#  create a relation > CourseTrack.create(course_id: 1, track_id: 1, order:2)

# Track.last.courses && Course.last.tracks

# get the order > CourseTrack.where(course_id: 1, track_id: 2).order

# User.first.tracks.create(user_id: 1, category_id: 1, name: 'yeee') will assign this track to an owner(User.first), and a user (means that the owner will be able to access it> adding a user_id will store the result in the join table, therefore making it accessible)


#
#forking >
# new_track = Track.includes(:courses).find("track_id").dup
# UserTrack.create(user_id: session[:user_id], track_id: new_track), after that User.find(session[:user_id]).tracks will include the newly forked track
# User.find(session[:user_id]).tracks.find(11).courses.delete(20), deletes a course from a duplicated track without affecting neither the course nor the original track themselves.


require 'open-uri'

require 'json'

result = JSON.parse(open("https://api.coursera.org/api/catalog.v1/categories?includes=courses").read)['elements']

result.each do |category|
  cat = Category.create(name: category['name'])
  category['links']['courses'].each do |course_id|
    begin
      course = JSON.parse(open("https://api.coursera.org/api/catalog.v1/courses/#{course_id}").read)['elements'][0]
      Course.create(name: course['name'], url: "https://www.coursera.org/course/#{course['shortName']}", category_id: cat.id)
    rescue OpenURI::HTTPError => ex
      next
    end
  end
end

