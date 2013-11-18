class SentmessagesController < ApplicationController
    before_filter :authenticate_user!

    def index
        @sentmessages = Message.page(params[:page]).where(:user_id => current_user.id).order("created_at desc")
    end
end