require 'rails_helper'

describe Category do
   xit 'should get fixed' do
    category = Category.new(name: nil)
    expect(category.errors[:name]).to include("can't be blank")
  end
end
