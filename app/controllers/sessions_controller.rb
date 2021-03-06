# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def create
    author = Author.find_by_email(params[:email].downcase)
    if author&.authenticate(params[:password])
      if author.email_confirmed
        login_in author
        redirect_back author
      end
      session[:author_id] = author.id
      redirect_to root_path, notice: 'Logged in!'
    else
      flash.now[:alert] = 'Email or password is invalid'
      render 'new'
    end
  end

  def destroy
    session[:author_id] = nil
    redirect_to root_path, notice: 'Logged out!'
  end
end
