class AdminController < ApplicationController
  def index
  end

  def sessions
  end

  def users
		@users = User.find(:all)
  end
	def update_users
		redirect_to :action => :users
	end
end
