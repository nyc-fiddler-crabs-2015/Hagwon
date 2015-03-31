#  create a relation > CourseTrack.create(course_id: 1, track_id: 1, order:2)

# Track.last.courses && Course.last.tracks

# get the order > CourseTrack.where(course_id: 1, track_id: 2).order

# User.first.tracks.create(user_id: 1, category_id: 1, name: 'yeee') will assign this track to an owner(User.first), and a user (means that the owner will be able to access it> adding a user_id will store the result in the join table, therefore making it accessible)

require 'open-uri'
# require 'json'

# result = JSON.parse(open("https://api.coursera.org/api/catalog.v1/categories?includes=courses").read)['elements']

# result.each do |category|
#   cat = Category.create(name: category['name'])
#   category['links']['courses'].each do |course_id|
#     begin
#       course = JSON.parse(open("https://api.coursera.org/api/catalog.v1/courses/#{course_id}").read)['elements'][0]
#       Course.create(name: course['name'], url: "https://www.coursera.org/course/#{course['shortName']}", category_id: cat.id)
#     rescue OpenURI::HTTPError => ex
#       next
#     end
#   end
# end



# doc = Nokogiri::HTML(open("https://www.codeschool.com/courses"))

# hey = doc.css('.course-title').map{|x| x.children}

# links = hey.map{|x| "http://codeschool.com#{x[1].attributes['href'].value}"}

#yo = doc.css('article')
#yo[0].css('img')[0].attributes['src']
# h = doc.css('article').map{|x|

category = Category.find(7)
require 'nokogiri'
doc = Nokogiri::HTML(open("https://www.codeschool.com/courses"))

array_elements = doc.css('article').map{|x| x.children}
# array_elements[1].children[5].children[1].children[0].text
array_elements.each do |el|
  course = {photo_url: el.css('img')[0].attributes['src'].value,
    url: "http://codeschool.com#{el[1].children[1].attributes['href'].value}",
    name: el.children[5].children[1].children[0].text}
  category.courses.create(course)
  puts "SEEDED"
end
# x.css('img')[0].attributes['src'].value}
# url = doc.css('article')[0].children[3].children[3].children[1].attributes['href'].value
# h = doc.css('article')[0].children[3].children[3].children[1].children.last.text

