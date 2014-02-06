class TopicsController < ApplicationController
    before_filter :authenticate_user!

    def index
        if params[:format]
            @topics = Topic.where(:forum_id => params[:format].to_i)
        else
            @topics = Topic.page(params[:page])
        end
    end

    def new
        @topic = Topic.new
    end

    def latest
        #Empty holder controller
    end

    def create
        @topic = Topic.new(params[:topic])
        @topic.user_id = current_user.id

        respond_to do |format|
            if @topic.save
                flash[:notice] = 'Topic was successfully created.'
                format.html { redirect_to(topic_path(@topic.id))}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
            end
        end
    end

    def edit
        @topic = Topic.find(params[:id])
    end

    def update
        @topic = Topic.find(params[:id])

            respond_to do |format|
            if @topic.update_attributes(params[:topic])
                format.html { redirect_to(@topic, :notice => 'Forum was successfully updated.') }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @topic.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @posts = Topic.find(params[:id]).posts("created_at desc").page(params[:page])
        @post = Post.new
        @pointer = true
    end

    def destroy
        @topic = Topic.find(params[:id])
        @topic.destroy

        redirect_to topics_path
    end
end