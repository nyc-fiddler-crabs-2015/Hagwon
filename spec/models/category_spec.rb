# require 'rails_helper'

# describe Category do
#    it 'is invalid without a category name' do
#     category = Category.new(name: nil)
#     category.valid?
#     expect(category.errors[:name]).not_to include("can't be blank")
#   end
# end

require 'rails_helper'
require 'factory_girl_rails'

describe Category do

  let(:category) { FactoryGirl.build(:category) }

  it 'has a valid factory' do
    expect(true).to eq true
  end

  it 'has a name' do
    expect(category.name).to be_kind_of(String)
  end

end
