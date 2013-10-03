class RootController < ApplicationController
	before_filter :authenticate_user!
	skip_before_filter :authenticate_user!, :only => :home
  def home
  	if user_signed_in?
  		redirect_to "/home"
  	end
  end

  def userhome
  end

  def show
        @user = User.find_by_alias(params[:alias])  
        if !@user 
            redirect_to "/404"
        end
  end
end