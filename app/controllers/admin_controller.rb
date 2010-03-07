require 'auxiliary'
def authorized?
  user = User.find_by_name(session[:name])
  return true if user != nil and user.admin
  return false
end

class AdminController < ApplicationController
  def index
    redirect_to :action => :unauthorized and return unless authorized?
  end

  def sessions
    redirect_to :action => :unauthorized and return unless authorized?
  end

  def manage_users
    redirect_to :action => :unauthorized and return unless authorized?
		@users = User.find(:all)
  end
  def save_users
    redirect_to :action => :unauthorized and return unless authorized?
    enabled = params["user_enabled"]
    User.find(:all).each do |user|
      if enabled.include?(user.id.to_s) != user.enabled
        user.enabled = (not user.enabled)
        user.save
      end
    end
    redirect_to :action => :index
  end
	def update_users
    redirect_to :action => :unauthorized and return unless authorized?
		redirect_to :action => :users
	end
  def delete_users
    redirect_to :action => :unauthorized and return unless authorized?
		@users = User.find(:all)
    user_to_delete = User.find_by_id(params[:id])
    if user_to_delete != nil
      user_to_delete.destroy
      redirect_to :action => :index
    end
  end
  def clean_comments
    redirect_to :action => :unauthorized and return unless authorized?
    for comment in Comment.find(:all)
      comment.text = comment.text.clear
      comment.save
      comment.delete if User.find_by_id(comment.target_id) == nil
    end
    redirect_to :action => index
  end
  def remove_comments
    redirect_to :action => :unauthorized and return unless authorized?
    @users = User.find(:all, :order => "name")
    comment_to_remove = Comment.find_by_id(params[:comment])
    if comment_to_remove != nil   
      comment_to_remove.delete
    end
  end
  def reset_password
    redirect_to :action => :unauthorized and return unless authorized?
    @users = User.find(:all)
    user_to_reset =  User.find_by_id(params[:id])
    if user_to_reset != nil
      user_to_reset.password = "1234"
      user_to_reset.save
    end
  end
  def show_common_comments
    redirect_to :action => :unauthorized and return unless authorized?
    comments_array = Comment.find(:all).collect{|c| [c.text, c.target_id]}.uniq.collect{|c| c[0]}
    @comments = comments_array.uniq.collect{|c| [c,comments_array.count(c)]}.sort{|a,b| b[1] <=> a[1]}
  end
  def hide_all_users
    redirect_to :action => :unauthorized and return unless authorized?
    User.find(:all).each{|u| u.shown = false; u.save}
    redirect_to :action => :index
  end
  def show_all_users
    redirect_to :action => :unauthorized and return unless authorized?
    User.find(:all).each{|u| u.shown = true; u.save}
    redirect_to :action => :index
  end
  def edit_session
    @current_session = Session.current
  end
  def update_session
    @current_session = Session.find_by_id(params[:session][:id])
    @current_session.update_attributes(params[:session]) unless @current_session == nil
    redirect_to :action => :edit_session
  end
  def unauthorized
    
  end
end
