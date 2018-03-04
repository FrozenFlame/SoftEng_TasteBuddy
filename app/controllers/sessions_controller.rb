class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    puts "[sessions_controller] PLEASE"
    # if user && (pass == params[:password])
    if user
      puts "[sessions_controller] user recognized!"
      pass = user.read_attribute(:password)
      if  pass == params[:password]
      session[:user_id] = user.read_attribute(:userid)
      session[:is_admin] = user.read_attribute(:isAdmin)
      
      puts "[sessions_controller] logged in!"
      redirect_to root_url, notice: "Logged in!"
      else
        puts "[sessions_controller] failed to log in!"
        flash.now[:notice] = "Email or password is invalid"
        render "new"
      end
      
    else
      flash.now[:notice] = "Email or password is invalid"
      render "new"
    end

  end
  
  def logout
    reset_session
    redirect_to root_url, notice: "Successfully logged out!"
  end

  def cart

  end

end
