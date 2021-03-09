class UserController < ApplicationController

  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def friends
    @friends = current_user.friends
  end

  def search
    if params[:user].empty?
      flash.now[:alert] = 'Please enter a valid name'
      respond_to do |format|
        format.js { render partial: 'user/result' }
      end
    else
      @friends = current_user.findFriend(params[:user])
      if @friends
        @friends = @friends.reject {|user| user.email.eql?(current_user.email)}
        respond_to do |format|
          format.js { render partial: 'user/result' }
        end
      else
        flash.now[:alert] = 'Please enter a valid name'
        respond_to do |format|
          format.js { render partial: 'user/result' }
        end
      end
    end
  end

  def send_friend_request
    current_user.friends << params[:friend]
  end

  def unfollow_friend
    current_user.unfollow(params[:email])
  end
end
