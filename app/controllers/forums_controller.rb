class ForumsController < ApplicationController
    before_filter :authenticate_user!

    def index
        if params[:format]
            @forums = Forum.where(:id => params[:format])
        else
            @forums = Forum.page(params[:page])
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
        @topics = Forum.find(params[:id]).topics.page(params[:page])
    end

    def edit
        @forum = Forum.find(params[:id])
    end

    def update
        @forum = Forum.find(params[:id])

            respond_to do |format|
            if @forum.update_attributes(params[:forum])
                format.html { redirect_to(@forum, :notice => 'Forum was successfully updated.') }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @forum = Forum.find(params[:id])
        @forum.destroy

        redirect_to forums_path
    end
end