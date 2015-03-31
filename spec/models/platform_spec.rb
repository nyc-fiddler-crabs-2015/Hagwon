require 'rails_helper'

describe Platform do
  let(:platform) { FactoryGirl.build(:platform) }

  it 'is valid with name,logo_url' do
  expect(platform).to be_valid
  end

  it 'has a valid factory' do
    expect(true).to eq true
  end

  it 'has a name' do
    expect(platform.name).to be_kind_of(String)
  end

  it 'has a url' do
    expect(platform.logo_url).to be_kind_of(String)
  end
end
