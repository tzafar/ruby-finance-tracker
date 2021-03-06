class StocksController < ApplicationController

  def search
    if params[:stock].present?
      @stock = Stock.get_price(params[:stock])
      if @stock
        respond_to do |format|
          format.js { render partial: 'user/result' }
        end
      else
        respond_to do |format|
          flash[:alert] = 'Please enter a valid symbol'
          format.js { render partial: 'user/result' }
        end
      end
    else
      respond_to do |format|
        flash.now[:alert] = 'Please enter a valid symbol'
        format.js { render partial: 'user/result' }
      end
    end
  end
end