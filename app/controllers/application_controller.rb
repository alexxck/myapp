# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  def current_user
    if session[:author_id]
      @current_user ||= Author.find(session[:author_id])
    else
      @current_user = nil
    end
  end

  def require_login
    redirect_to login_path unless logged_in?
    # add some flash mess, dont forget
    # ###############
  end

  def login_in(author)
    session[:author_id] = author.id
  end

  def logged_in?
    !current_user.nil?
  end
end
