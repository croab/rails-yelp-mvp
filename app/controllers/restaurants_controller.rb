class RestaurantsController < ApplicationController
  before_action :find_restaurant, only: [:show]
  def index
    @restaurants = Restaurant.all
  end

  def show
    @reviews = @restaurant.reviews
    @review = Review.new
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new(restaurant_params)
    if @restaurant.save
      redirect_to restaurant_path(@restaurant), status: :see_other
    else
      render new_restaurant_path, status: :unprocessable_entity
    end
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find(params[:id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:name, :address, :phone_number, :category)
  end
end
