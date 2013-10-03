class PostsController < ApplicationController
    before_filter :authenticate_user!

    def index
        @posts = Post.page(params[:page])
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(params[:post])
        @post.user_id = current_user.id

        respond_to do |format|
            if @post.save
                flash[:notice] = 'Post was successfully created.'
                format.html { redirect_to(post_path(@post.topic_id))}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @forum.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @posts = Post.where(:topic_id => params[:id]).page(params[:page])
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        redirect_to posts_path
    end
end