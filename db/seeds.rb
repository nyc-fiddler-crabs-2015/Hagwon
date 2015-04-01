
require 'open-uri'
require 'json'

coursera = Platform.create(name: 'Coursera', logo_url: "https://d3q6qq2zt8nhwv.cloudfront.net/platform/4b9a27f7ca854bbd9a245d55310bc727.png")

result = JSON.parse(open("https://api.coursera.org/api/catalog.v1/categories?includes=courses").read)['elements']

result.each do |category|
  cat = Category.create(name: category['name'])
  category['links']['courses'].each do |course_id|
    begin
      course = JSON.parse(open("https://api.coursera.org/api/catalog.v1/courses/#{course_id}").read)['elements'][0]
      Course.create(name: course['name'], url: "https://www.coursera.org/course/#{course['shortName']}", category_id: cat.id, platform_id: coursera.id)
    rescue OpenURI::HTTPError => ex
      next
    end
  end
end



codeschool = Platform.create(name: 'CodeSchool', logo_url: "http://kevinhamiltonsmith.com/wp-content/uploads/2013/05/code_school.png")

category = Category.find(15)
require 'nokogiri'
doc = Nokogiri::HTML(open("https://www.codeschool.com/courses"))

array_elements = doc.css('article').map{|x| x.children}

array_elements.each do |el|
  course = {photo_url: el.css('img')[0].attributes['src'].value,
    url: "http://codeschool.com#{el[1].children[1].attributes['href'].value}",
    name: el.children[5].children[1].children[0].text, platform_id: codeschool.id}
  category.courses.create(course)
  puts "SEEDED"
end


