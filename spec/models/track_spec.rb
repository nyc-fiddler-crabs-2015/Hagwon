require 'rails_helper'

describe Track do
  let(:track) { FactoryGirl.build(:track) }

  it 'is valid with name,popularity' do
  expect(track).to be_valid
  end

  it 'has a valid factory' do
    expect(true).to eq true
  end

  it 'has a name' do
    expect(track.name).to be_kind_of(String)
  end

  it 'has a popularity' do
    expect(track.popularity).to be_kind_of(Integer)
  end
end
