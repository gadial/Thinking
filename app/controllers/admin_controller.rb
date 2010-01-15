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
  def delete_users
    redirect_to :action => :unauthorized unless authorized?
		@users = User.find(:all)
    STDERR.puts @users.inspect
    user_to_delete = User.find_by_id(params[:id])
    if user_to_delete != nil
      user_to_delete.destroy
      redirect_to :action => :index
    end
  end
  def clean_comments
    redirect_to :action => :unauthorized unless authorized?
    for comment in Comment.find(:all)
      comment.text = comment.text.clear
      comment.save
    end
    redirect_to :action => index
  end
  def remove_comments
    redirect_to :action => :unauthorized unless authorized?
    @users = User.find(:all, :order => "name").reject{|u| u.participates == 0}
    comment_to_remove = Comment.find_by_text_and_target_id(params[:comment],params[:target_id])
    if comment_to_remove != nil   
      comment_to_remove.delete
    end
  end
  def reset_password
    redirect_to :action => :unauthorized unless authorized?
    @users = User.find(:all)
    user_to_reset =  User.find_by_id(params[:id])
    if user_to_reset != nil
      user_to_reset.password = "1234"
      user_to_reset.save
    end
  end
  def unauthorized
    
  end
end
