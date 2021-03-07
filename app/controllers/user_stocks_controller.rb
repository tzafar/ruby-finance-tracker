class UserStocksController < ApplicationController
  def create
    stock = Stock.present_in_db(params[:ticker]).first
    if !stock
      stock = Stock.look_up(params[:ticker])
      stock.save
    end
    UserStock.create(user: current_user, stock: stock)
    flash[:notice] = "Stock #{stock.name} is added to your portfolio"
    redirect_to my_portfolio_path
  end

  def destroy
    UserStock.where(user_id: current_user.id, stock_id: params[:id]).first.destroy
    flash[:notice] = "Removed successfully"
    redirect_to my_portfolio_path
  end
end