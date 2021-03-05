class StocksController < ApplicationController
  def search
    @stock = Stock.get_price(params[:stock])
    render 'user/my_portfolio'
  end
end