class UsersController < ApplicationController

  def index
  end

  def show
    @user = User.find(session[:user_id])
    @my_secrets = @user.secrets
    @secrets_liked_by_me = @user.secrets_liked
    render 'show.html.erb'
  end

  def secrets
    @secrets = Secret.all
    @user=User.find(session[:user_id])
  end


  def postsecret
    user = User.find(session[:user_id])

    # LOOK HERE FOR CREATING A REFERENCE
    seek = Secret.create(description: params[:secret_description], user:user)
     redirect_to "/users/#{session[:user_id]}"
  end

  def delete
    Secret.find(params[:id]).destroy
    redirect_to "/users/#{session[:user_id]}"
  end

  def like
    @user_id=session[:user_id]
    Like.create(secret_id:params[:id],user_id:@user_id)
    flash[:success]="new Like created"

    # user = User.find(session[:user_id])
    # secret = Secret.find(params[:id])
    # unless secret.users.include?(user)
    #   like = Like.create(user:user, secret:secret)
    #   end
    redirect_to "/users/#{session[:user_id]}"
  end

  def unlike
    @user_id=session[:user_id]
    Like.where(secret_id:params[:id],user_id:@user_id)[0].destroy
    flash[:success]=["Like changed to an UNLIKE"]
    redirect_to '/secrets'
  end

  def logout
    reset_session
    redirect_to('/users')
  end


  def create

    user = User.create(name: params[:name],email:params[:email],password:params[:password],password_confirmation:params[:password_confirmation])

    if user.valid?
      session[:user_id] = user[:id]
      puts session[:user_id]

      redirect_to "/users/#{session[:user_id]}"
    else
      render json: user.errors
    end
  end

  def login
    # render json: params
    puts "Is this actually running"
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user[:id]

      puts session[:user_id]
      redirect_to "/users/#{session[:user_id]}"
    else
      render text:"something was wrong with login credentials"
    end
  end


end
