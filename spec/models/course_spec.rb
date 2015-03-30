require 'rails_helper'

describe Course do
  it 'is valid with a name and url' do
    course = Course.new(
      name: 'Introduction to Python',
      url: 'www.example.com'
      )
    expect(course).to be_valid
  end
end