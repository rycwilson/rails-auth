class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # While all helper methods are available in all views,
  # they aren't available in controllers, so we must
  # include the helper module here
  # (or include it in the specific controller)
  include SessionsHelper

end
