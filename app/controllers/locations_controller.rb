class LocationsController < ApplicationController
    before_filter :authenticate_user!
    def new
        if User.find(current_user).location != nil
            redirect_to(:controller => 'locations', :action => 'edit')
        end
        @location = Location.new
    end
    def index
        if User.find(current_user).location == nil
            redirect_to(:controller => 'locations', :action => 'new')
            flash[:notice] = "You are required to input your location before you can view others"
        elsif params[:name]
            redirect_to(:controller => "root", :action => "show", :alias => params[:name])
        else
            if params[:alias1]
                @users = []
                params.each do |key, value|
                    user =  User.find_by_alias(value)
                    if user != nil
                        @users << user
                    end
                end
            else
                @users =  User.joins(:location).all
            end
            respond_to do |format|
                format.html { render :html => @users }
                format.json { render :json => @users.to_json(:include => :location) }
            end
        end
    end

    def edit
        @location = Location.find(current_user)
    end

    def update
        @location = Location.find(params[:id])

        respond_to do |format|
            if @location.update_attributes(params[:location])
                format.html { redirect_to(:action => "index") }
                flash[:notice] = 'Location was successfully updated.'
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
            end
        end
    end

    def create
        @location = Location.new(params[:location])
        @location.user_id = current_user.id

        respond_to do |format|
            if @location.save
                format.html { redirect_to(:controller => 'root', :action => 'userhome' )}
                flash[:notice] = 'Location was successfully input.'
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
            end
        end
    end

    def

    def show
        @location = Location.find_by_user_id(current_user)
    end
end