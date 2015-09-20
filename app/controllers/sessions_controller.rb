class SessionsController < ApplicationController
  def new
  end
  def create
      user = User.find_by(email: params[:session][:email].downcase)
   if user && user.authenticate(params[:session][:password])
      # Log the user in and redirect to the user's show page.
      log_in user
        redirect_to user
  else
      flash[:danger] ='Invalid email/password combination'# Not quite right!
      # Create an error message.render 'new'
      render 'new'
   end
   end
   def destroy
       log_out
       cookies.delete(:auth_token)
      redirect_to root_url
  end
  def redirect_back_or(default)
      redirect_to(session[:forwarding_url] || default)
      session.delete(:forwarding_url)
  end
      # Stores the URL trying to be accessed.
  def store_location
      session[:forwarding_url] = request.url if request.get?
  end
  def current_user
      @current_user ||= User.find_by(id: session[:user_id])
   if @current_user.nil?
      @current_user = User.find_by(id: session[:user_id])
   else
      @current_user
   end
end
end
