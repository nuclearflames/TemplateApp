class FriendsController < ApplicationController
    before_filter :authenticate_user!
    skip_before_filter :authenticate_user!, :only => :home
    
    def create
        @friendid = User.find_by_alias(params[:alias]).id
        @friend = Friend.new
        @friend.user_id = current_user.id
        @friend.friend_id = @friendid

        respond_to do |format|
            if @friend.save
                format.html { redirect_to( :controller => "root", :action => "home")}
                flash[:notice] = 'User added as a friend.'
            else
                format.html { render :action => "errors" }
                format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
            end
        end
    end

    def errors
    end

    def confirm
        #Confirm friend
        @friend = Friend.find(params[:id])
        @friend.confirmed = true

        #Create friend in reverse
        @friend2 = Friend.new
        @friend2.user_id = current_user.id
        @friend2.friend_id = @friend.user_id
        @friend2.confirmed = true

        respond_to do |format|
            if @friend.save && @friend2.save
                format.html { redirect_to( :controller => "root", :action => "home")}
                flash[:notice] = 'User confirmed as a friend.'
            else
                format.html { render :action => "errors" }
                format.xml  { render :xml => @friend.errors, :status => :unprocessable_entity }
            end
        end
    end

    def deny
        @friend = Friend.find(params[:id])
        @friend.destroy

        redirect_to :controller => "root", :action => "userhome"
        flash[:notice] = 'Friendship removed.'
    end

    def update
    end
end