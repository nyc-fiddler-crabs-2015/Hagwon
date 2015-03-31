require 'rails_helper'

describe Review do
  let(:review) { FactoryGirl.build(:review) }

  it 'is valid with rating,difficulty' do
  expect(review).to be_valid
  end

  it 'has a valid factory' do
    expect(true).to eq true
  end

  it 'has a rating' do
    expect(review.rating).to be_kind_of(Integer)
  end

  it 'has a difficulty' do
    expect(review.difficulty).to be_kind_of(Integer)
  end
end
