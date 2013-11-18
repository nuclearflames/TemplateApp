class MessagesController < ApplicationController
    before_filter :authenticate_user!

    def index
        @messages = Message.page(params[:page]).where(:user_id => current_user.id).order("created_at desc")
    end

    def new
        @message = Message.new
    end

    def create
        @message = Message.new(params[:message])
        @message.user_id = current_user.id
        @message.recipient_id = User.where(:alias => params[:message][:recipient_id]).first.id

        respond_to do |format|
            if @message.save
                flash[:notice] = 'Message successfully sent.'
                format.html { redirect_to(messages_path)}
            else
                format.html { render :action => "new" }
                format.xml  { render :xml => @message.errors, :status => :unprocessable_entity }
            end
        end
    end

    def show
        @message = Message.find(params[:id])
        if (current_user.id == @message.recipient_id)
            @message.update_attribute(:read, true);
        end
        @recipient = User.find(@message.recipient_id).alias
    end

    def update(param)
        @post.update(param)
    end

    def destroy
        @message = Message.find(params[:id])
        # If message deleted is owned and sent to self destroy
        # elseIf owner destroying then set to deleted
        # elseIf recipient destroys remove recipient ID
        # elseIf both deleted and no recipient ID, destroy
        if @message.user_id == current_user.id && @message.recipient_id == current_user.id
            @message.destroy
        elsif @message.user_id == current_user.id
            if @message.recipient_id = nil
                @message.destroy
            else
                @message.deleted = true
            end
        elsif @message.recipient_id == current_user.id
            if @message.deleted = true
                @message.destroy
            else
                @message.recipient_id = nil
            end
        end
        redirect_to messages_path
    end
end