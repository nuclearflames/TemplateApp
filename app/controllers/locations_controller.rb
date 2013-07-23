class LocationsController < ApplicationController
    before_filter :authenticate_user!
    def new
        @location = Location.new
        if Location.find_by_user_id(current_user.id)
            redirect_to(:controller => 'locations', :action => 'edit')
        end
    end
    def index
        @users = User.all
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
        @location = Location.find_by_users_id(current_user)
    end
end