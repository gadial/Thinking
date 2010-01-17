class MainController < ApplicationController
	def results
    redirect_to :action => :index unless Session.current.results_view_enabled
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
		@user = User.new
		@user.participates = 0 #pending manual authorization
	end
	def add_user
		@user = User.new(params[:user])
		 if @user.save
        flash[:notice] = 'המשתמש נוצר בהצלחה'
        render :action => "index"
      else
        render :action => "register"
      end
	end
	def update_user
		@user = User.find_by_name(session[:name])
		if @user.update_attributes(params[:user])
			flash[:notice] = "המשתמש עודכן בהצלחה"
		end
			render :action => "index"
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
    redirect_to :action => :index unless Session.current.commenting_enabled
		@users = User.find(:all, :order => "name")
	end
	def edit_password
		@user = User.find_by_name(session[:name])
	end
  def save_comments
    comments = {}
    params.find_all{|key, val| key =~ /^user_.*/}.each do |pair|
      pair[0] =~ /^user_/
      comments[$'] = pair[1]
    end
    User.find(:all).each do |user|
      comments_string = comments[user.name]
      user.set_comments(comments_string, session[:name])
    end
    flash[:notice] = "ההערות שונו בהצלחה"
    redirect_to :action => "index"
  end
	def index
		if session[:name] != nil
			@user = User.find_by_name(session[:name])
		end
	end
end
