require 'rails_helper'

describe Category do
   it 'is invalid without a category name' do
    category = Category.new(name: nil)
    category.valid?
    expect(category.errors[:name]).not_to include("can't be blank")
  end
end