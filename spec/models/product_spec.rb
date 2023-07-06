require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Validations' do
      it 'saves a product successfully' do
        @category = Category.new({name: 'Bushes'})
        @product = @category.products.new({name: 'Bush', price: 600, quantity: 50}).save
        expect(@product).to eq(true)
      end

      it 'is not valid without a name' do
        @category = Category.new({name: 'Bushes'})
        @product = @category.products.new({name: nil, price: 600, quantity: 50})
        expect(@product).to_not be_valid
      end

    it 'is not valid without a price' do
      @category = Category.new({name: 'Bushes'})
      @product = @category.products.new({name: 'Bush', quantity: 50})
      expect(@product).to_not be_valid
    end

    it 'is not valid without a quantity' do
      @category = Category.new({name: 'Bushes'})
      @product = @category.products.new({name: 'bush', price: 600, quantity: nil})
      expect(@product).to_not be_valid
    end

    it 'is not valid without a category' do
      @product = Product.new({name: 'Weed', price: 600, quantity: 50})
      expect(@product).to_not be_valid
    end

  end
end
