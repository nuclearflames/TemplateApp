class ForumsController < ApplicationController
    before_filter :authenticate_user!

    def index
        if params[:format]
            @forums = Forum.where(:id => params[:format])
        else
            @forums = Forum.all
        end
    end

    def new
        @forum = Forum.new
    end

    def create
        @forum = Forum.new(params[:forum])
        @forum.user_id = current_user.id

        respond_to do |format|
            if @forum.save
                flash[:notice] = 'Forum was successfully created.'
                format.html { redirect_to(:controller => 'forums', :action => 'index' )}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @forum = Forum.find(params[:id])
    end
end