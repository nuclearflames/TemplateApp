class ApplicationController < ActionController::Base
    protect_from_forgery
    before_filter :set_layout_variables

    def set_layout_variables
        if current_user
            @user = User.find(current_user)
        end
    end

end
