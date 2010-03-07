def authorized?
  user = User.find_by_name(session[:name])
  return true if user != nil and user.admin
  return false
end

class MainController < ApplicationController
	def commenting_results
    redirect_to :action => :index unless Session.current.commenting_results_view_enabled
		@users = User.find(:all, :order => "name")
		session[:view_type] ||= "normal_view"
    temp_user = User.find_by_name(session[:name])
    session[:view_type] = temp_user.view_type if temp_user != nil
	end
	def set_view_type
		@users = User.find(:all, :order => "name")
    session[:view_type] = params[:view_type]
    temp_user = User.find_by_name(session[:name])
    if params[:view_type] != nil and temp_user != nil
      temp_user.view_type = params[:view_type]
      temp_user.save
    end
		render :partial => "result_user_list"
	end
	def register
    redirect_to :action => :index unless Session.current.registration_enabled
		@user = User.new
	end
	def add_user
		@user = User.new(params[:user])
    @user.last_visit_to_result_list = Time.now
		 if @user.save
        flash[:notice] = 'המשתמש נוצר בהצלחה'
        session[:name] = @user.name
        redirect_to :action => "index"
      else
        render :action => "register"
      end
	end
	def update_user
		@user = User.find_by_name(session[:name])
		if @user.update_attributes(params[:user])
			flash[:notice] = "המשתמש עודכן בהצלחה"
		end
			redirect_to :action => "index"
	end
  def login
    name = params[:name]
    password = params[:password]
    if name != nil
      user = User.find_by_name(name)
      if user == nil
        flash.now[:error] = "שם המשתמש לא נמצא במערכת"
      else
        if user.password_hash == User.hashed_password(password, user.salt)
          flash[:notice] = "ההתחברות הושלמה בהצלחה"
          session[:name] = user.name
          redirect_to :action =>"index"
        else
          flash.now[:error] = "הססמא שגויה"
        end
      end
    end
  end
  def logout
    session[:name] = nil
    redirect_to :action => "index"
  end
	def edit_comments
    redirect_to :action => :index and return unless Session.current.commenting_enabled or authorized?
		@users = User.find(:all, :order => "name")
	end
	def edit_password
		@user = User.find_by_name(session[:name])
	end
  def save_comments
    redirect_to :action => :index and return unless params[:active] != nil and User.can_add_comments(session[:name])
    comments = {}
    params.find_all{|key, val| key =~ /^user_.*/}.each do |pair|
      pair[0] =~ /^user_/
      comments[$'] = pair[1]
    end
    User.find(:all).reject{|user| user.name == session[:name]}.each do |user|
      comments_string = comments[user.name]
      user.set_comments(comments_string, session[:name])
    end
    flash[:notice] = "ההערות שונו בהצלחה"
    redirect_to :action => "index"
  end
	def index
		if session[:name] != nil
			@user = User.find_by_name(session[:name])
      @new_comment_number = Comment.number_of_comments(@user.last_visit_to_result_list)
		end
	end
  def results
    redirect_to :action => :index and return unless Session.current.commenting_results_view_enabled or authorized?
    @users = User.find(:all, :order => "name")
    if session[:name]
      @user = User.find_by_name(session[:name])
      @user.last_visit_to_result_list = Time.now
      @user.save
    end
    session[:min_time] = ((params[:min_time] != nil)?(Time.parse(params[:min_time])):(nil))
  end
end
