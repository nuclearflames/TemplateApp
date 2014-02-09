class RootController < ApplicationController
    before_filter :authenticate_user!
    skip_before_filter :authenticate_user!, :only => :home
    def home
        if user_signed_in?
        	redirect_to "/home"
        end
    end

    def userhome
        @news = User.find(current_user).news.page(params[:page])
        @posts = User.find(current_user).posts("created_at desc").page(params[:page]).per(5)
        @unconfirmedusers = Friend.where(:friend_id => current_user.id, :confirmed => false)
        @pointer = true
    end

    def show
        @user = User.find_by_alias(params[:alias])
        if !@user
            redirect_to "/404"
        end
    end
end