class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.get_price(params[:stock])
      if @stock
        render 'user/my_portfolio'
      else
        flash[:alert] = 'Please enter a valid symbol'
        redirect_to my_portfolio_url
      end
    else
      flash[:alert] = 'Please enter a valid symbol'
      redirect_to my_portfolio_url
    end
  end
end