class Admin::DashboardController < ApplicationController
  
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'].to_s, password: ENV['ADMIN_PASSWORD'].to_s
  
  def show
    @productCount = Product.count
    @categoryCount = Category.count
  end
  
end
