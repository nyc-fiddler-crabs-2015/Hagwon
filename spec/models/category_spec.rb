require 'rails_helper'

describe Category do
   it 'is invalid without a category name' do
    category = Category.new(name: nil)
    categoty.valid?
    expect(category.errors[:name]).to include("can't be bla")


  end
end