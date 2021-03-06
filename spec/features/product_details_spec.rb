require 'rails_helper'

RSpec.feature "Visitor navigates to home page", type: :feature, js: true do

  # SETUP
  before :each do
   @category = Category.create! name: 'Apparel'
     10.times do |n|
       @category.products.create!(
         name:  Faker::Hipster.sentence(3),
         description: Faker::Hipster.paragraph(4),
         image: open_asset('apparel1.jpg'),
         quantity: 10,
         price: 64.99
       )
     end
   end
 

   scenario "go to the product page" do
    # ACT
    visit root_path
    all('h4').select.first.click
    sleep 10
    # DEBUG
    # save_screenshot

    # VERIFY
    expect(page).to have_css 'dl-horizontal'
  end
end