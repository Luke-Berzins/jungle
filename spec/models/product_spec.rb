require 'rails_helper'

RSpec.describe Product, type: :model do
  it 'should create a new product' do
    @category = Category.new(:name => 'stuff')
    @category.save!
    @product = Product.new(:name => 'nice', :price => 1000, :quantity => 5, :category_id => @category.id)
    @product.save!
    expect(@product.name).to be_present
    expect(@product.price).to be_present
    expect(@product.quantity).to be_present
    expect(@product.category).to be_present
  end

  it 'name should be assigned on creation of new product' do
    @category = Category.new(:name => 'stuff')
    @category.save!
    @product = Product.new(:name => nil, :price => 1000, :quantity => 5, :category_id => @category.id)
    assert !@product.save
    assert @product.errors.full_messages.include? "Name can't be blank"
  end

  it 'price should be assigned on creation of new product' do
    @category = Category.new(:name => 'stuff')
    @category.save!
    @product = Product.new(:name => 'nice', :price => nil, :quantity => 5, :category_id => @category.id)
    assert !@product.save
    assert @product.errors.full_messages.include? "Price can't be blank"
  end

  it 'quantity should be assigned on creation of new product' do
    @category = Category.new(:name => 'stuff')
    @category.save!
    @product = Product.new(:name => 'nice', :price => 1000, :quantity => nil, :category_id => @category.id)
    assert !@product.save
    assert @product.errors.full_messages.include? "Quantity can't be blank"
  end

  it 'category should be assigned on creation of new product' do
    @product = Product.new(:name => 'nice', :price => 1000, :quantity => 5, :category_id => nil)
    assert !@product.save
    assert @product.errors.full_messages.include? "Category can't be blank"
  end
end
