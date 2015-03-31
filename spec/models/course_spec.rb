require 'rails_helper'

describe Course do

 it 'is valid with name,url' do
   course = Course.new(
        name: 'Introduction to rails',
        url: 'www.learn.com')
      expect(course).to be_valid
  end

  it 'is invalid without a name' do
    course = Course.new(name: nil)
    course.valid?
    expect(course.errors[:name]).not_to include("can't be blank")
  end

end

