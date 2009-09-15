class MainController < ApplicationController
	def results
		@view_type = 0
		@users = User.find(:all)
		params[:view_type] = "normal_view"
	end
	def display_results
		@users = User.find(:all)
		render :partial => "result_user_list"
	end
	def register
		@user = User.new
		@user.participates = 1
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
          session[:name] = name
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
		@users = User.find(:all)
	end
  def save_comments
    #TODO: check for double comments and remove them
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
    render :action => "index"
  end
	def index
		if session[:name] != nil
			@user = User.find_by_name(session[:name])
		end
	end
end
