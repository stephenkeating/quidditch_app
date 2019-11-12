# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...


How to Create a user with password

rails g resource User username password_digest

# must un-comment the BCrypt gem on the gemfile

Add this code to the User class:
has_secure_password

# has_secure_password does everything below:

def password=(plaintext_password)
  # this will run through BCRYPT and save to the password_digest field
  encrypted_password = BCrypt::Password.create(plaintext_password)
  # save to the password_digest field
  self.password_digest = encrypted_password
end

# following method returns false is it doesn't math, and the user instance if it matches
def authenticate(plaintext_password)  
  plaintext_password == BCrypt::Password.new(self.password_digest)
end


# creating a sign-up
route: user/new
in routes: get "/signup", to: "users#new"

# in users controller:

def new
  @user = User.new
  #render :new
end

def create
  user_params = params.require(:user).permit(:username, :password)
  user = User.create(user_params)

  session[:user_id] = user.id

  render_to example_path
end


# in views, create new.rb
  # create a form using @user with just a username field and a password field
  # to hide pssword, use f.password_field in the field for the form

# in the application_controller add:
  # at the top:
  before_action :set_current_user

  # under private:
  def set_current_user
    @current_user = User.find(session[:user_id])
  end
  

# in the application navbar, add: 
  <% if @current_user %> 
    Welcome, <%= @current_user.username %>
  # there's more to add here...
