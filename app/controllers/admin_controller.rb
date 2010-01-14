require 'auxiliary'
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
  def clean_comments
    for comment in Comment.find(:all)
      comment.text = comment.text.clear
      comment.save
    end
    redirect_to :action => index
  end
end
