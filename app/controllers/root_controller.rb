class RootController < ApplicationController
	before_filter :authenticate_user!
	skip_before_filter :authenticate_user!, :only => :home
  def home
  end

  def userhome
  end
end