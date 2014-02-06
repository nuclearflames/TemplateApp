class NewsController < ApplicationController
    before_filter :authenticate_user!

    def index
        @news = User.find(current_user).news.page(params[:page])
        respond_to do |format|
            format.html { render :html => @news }
            format.json { render :json => @news.to_json(:include => :user) }
        end
    end

    def new
        @news = News.new
    end

    def create
        @news = News.new(params[:news])
        @news.user_id = current_user.id

        respond_to do |format|
            if @news.save
                flash[:notice] = 'News was successfully created.'
                format.html { redirect_to(:controller => 'news', :action => 'index' )}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @news = News.find(params[:id])
    end

    def edit
        @news = News.find(params[:id])
    end

    def update
        @news = News.find(params[:id])

            respond_to do |format|
            if @news.update_attributes(params[:news])
                format.html { redirect_to(@news, :notice => 'News was successfully updated.') }
                format.xml  { head :ok }
            else
                format.html { render :action => "edit" }
                format.xml  { render :xml => @news.errors, :status => :unprocessable_entity }
            end
        end
    end

    def destroy
        @news = News.find(params[:id])
        @news.destroy

        redirect_to news_index_path
    end
end