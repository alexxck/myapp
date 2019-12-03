# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user, :logged_in?, :banned?
  before_action :unloged

  def banned?
    if current_user.present?
      if current_user.banned == true
        redirect_back(fallback_location: root_path)
        flash[:danger] = "You are banned☹️"
      end
    end
  end

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
