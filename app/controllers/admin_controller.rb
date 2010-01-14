require 'auxiliary'
def authorized?
  user = User.find_by_name(session[:name])
  return true if user != nil and user.admin
  return false
end

class AdminController < ApplicationController
  def index
    redirect_to :action => :unauthorized unless authorized?
  end

  def sessions
    redirect_to :action => :unauthorized unless authorized?
  end

  def users
    redirect_to :action => :unauthorized unless authorized?
		@users = User.find(:all)
  end
	def update_users
    redirect_to :action => :unauthorized unless authorized?
		redirect_to :action => :users
	end
  def clean_comments
    redirect_to :action => :unauthorized unless authorized?
    for comment in Comment.find(:all)
      comment.text = comment.text.clear
      comment.save
    end
    redirect_to :action => index
  end
  def unauthorized
    
  end
end
