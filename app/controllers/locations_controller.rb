class LocationsController < ApplicationController
    before_filter :authenticate_user!
    def new
        @location = Location.new
        if Location.find_by_user_id(current_user.id)
            redirect_to(:controller => 'locations', :action => 'edit')
        end
    end
    def index
        if params[:name]
            redirect_to(:controller => "root", :action => "show", :alias => params[:name])
        else
            @users =  User.where(location != nil)
            respond_to do |format|
                format.html { render :html => @users }
                format.xml { render :xml => @users }
            end
        end
    end

    def edit
        @location = Location.find_by_user_id(current_user)
    end

    def create
        @location = Location.new(params[:location])
        @location.user_id = current_user.id

        respond_to do |format|
            if @location.save
                flash[:notice] = 'Location was successfully created.'
                format.html { redirect_to(:controller => 'root', :action => 'userhome' )}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @location.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @location = Location.find_by_user_id(current_user)
    end
end