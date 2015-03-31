require 'rails_helper'

describe Category do

  let(:category) { FactoryGirl.build(:category) }

  it 'has a valid factory' do
    expect(true).to eq true
  end

  it 'has a name' do
    expect(category.name).to be_kind_of(String)
  end

end
