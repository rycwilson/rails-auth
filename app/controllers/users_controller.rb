class UsersController < ApplicationController

  before_action :require_login, only: :show

  def new
    @user = User.new
  end

  #
  # GET /user/:id
  #
  def show
    # use find_by if you're not certain that the id will not be nil
    # User.find(nil) will crash the app
    @user = User.find_by(id:session[:user_id]) || User.find(params[:id])
  end

  def create
    @user = User.new user_params
    if @user.valid?
      @user.save
      login(@user)
      redirect_to @user, flash: { success: "Welcome, #{@user.email}" }
    else
      # TODO: pass through user.errors.messages
      flash.now[:danger] = "Please fix these errors: #{@user.errors.messages}"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end

end
