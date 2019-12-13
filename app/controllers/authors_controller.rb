# frozen_string_literal: true

class AuthorsController < ApplicationController
  before_action :set_author, only: %i[show edit update destroy]
  def index
    @author = Author.all
  end

  def show; end

  def new
    @author = Author.new
  end

  def edit; end

  def create
    @author = Author.new(author_params)

    respond_to do |format|
      if @author.save
        @author.confirmation_token
        @author.save(validate: false)
        AuthorMailer.registration_confirmation(@author).deliver_now
        flash[:success] = 'Please confirm your email address to continue'
        format.html { redirect_to login_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @author }
      else
        flash[:error] = 'Invalid, please try again'
        format.html { render :new }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @author.update(author_params)
        format.html { redirect_to @author, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @author }
      else
        format.html { render :edit }
        format.json { render json: @author.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @author.destroy
    respond_to do |format|
      format.html { redirect_to author_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def confirm_email
    author = Author.find_by_confirm_token(params[:id]) # may be params[:token]?
    if author
      author.email_activate
      author.save(validate: false)
      redirect_to author
    else
      flash[:error] = 'Sorry. User does not exist'
      redirect_to root_url
    end
  end

  private

  def set_author
    @author = Author.find(params[:id])
  end

  def author_params
    params.require(:author).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
