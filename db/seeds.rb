#  create a relation > CourseTrack.create(course_id: 1, track_id: 1, order:2)

# Track.last.courses && Course.last.tracks

# get the order > CourseTrack.where(course_id: 1, track_id: 2).order

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

