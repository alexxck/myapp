# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :current_user
  def current_user
    if session[:author_id]
      @current_user ||= Author.find(session[:author_id])
    else
      @current_user = nil
    end
  end
end
