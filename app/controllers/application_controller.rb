# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?
  before_action :unloged


  def current_user
    if session[:author_id]
      @current_user ||= Author.find(session[:author_id])
    else
      @current_user = nil
    end
  end

  # checking logged or not
  def require_login
    redirect_to login_path unless logged_in?
    # add some flash
  end

  def login_in(author)
    session[:author_id] = author.id
  end

  def logged_in?
    !current_user.nil?
  end

  # offer to sing up/log in
  def unloged
    cookies[:actions] = if cookies[:actions]
                          cookies[:actions].to_i + 1
                        else
                          0
                        end
  end
end
