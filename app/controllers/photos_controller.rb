class PhotosController < ApplicationController
    before_filter :authenticate_user!

    def index
        if params[:name]
            @alias = User.find_by_alias(params[:name])
            @photos = Photo.where(:user_id => @alias)
        else
            @photos = Photo.page(params[:page])
        end
    end

    def new
        @photo = Photo.new
    end

    def create
        @photo = Photo.new(params[:photo])
        @photo.user_id = current_user.id

        respond_to do |format|
            if @photo.save
                flash[:notice] = 'Photo was successfully created.'
                format.html { redirect_to(photo_path(@photo.user_id))}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @photo.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @photo = Photo.find(params[:id])
    end
end