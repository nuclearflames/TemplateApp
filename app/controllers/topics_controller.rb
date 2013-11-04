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

    def create
        @topic = Topic.new(params[:topic])
        @topic.user_id = current_user.id

        respond_to do |format|
            if @topic.save
                flash[:notice] = 'Topic was successfully created.'
                format.html { redirect_to(topic_path(@topic.forum_id))}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @posts = Topic.find(params[:id]).posts.page(params[:page])
        @post = Post.new
    end

    def destroy
        @topic = Topic.find(params[:id])
        @topic.destroy

        redirect_to topics_path
    end
end