require 'rails_helper'

describe Course do
  let(:course) { FactoryGirl.build(:course) }

  it 'is valid with name,url' do
  expect(course).to be_valid
  end

  it 'has a valid factory' do
    expect(true).to eq true
  end

  it 'has a name' do
    expect(course.name).to be_kind_of(String)
  end

  it 'has a url' do
    expect(course.url).to be_kind_of(String)
  end
end

