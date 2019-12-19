# frozen_string_literal: true

require 'will_paginate/array'
class PostsController < ApplicationController
  before_action :set_post, only: %i[show edit update destroy]
  before_action :require_login, only: %i[create edit update destroy]
  before_action :owner, only: %i[edit update destroy]
  before_action :banned?, only: %i[new create update]
  impressionist actions: [:show]

  # GET /posts
  def index
    @posts = if params[:search]
               Post.search(params[:search]).order('created_at DESC').paginate(page: params[:page], per_page: 8)
             else
               Post.all.order('created_at DESC').paginate(page: params[:page], per_page: 8)
             end
  end

  def show
    impressionist(@post)
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    if (!@current_user.banned?) && (@current_user.email_confirmed?)
      @post = current_user.posts.build(post_params)
      respond_to do |format|
        if @post.save
          format.html { redirect_to @post, notice: 'Post was successfully created.' }
        else
          format.html { render :new }
        end
      end
    else
      redirect_to root_path, notice: 'You dont have rights'
    end
  end

  def update
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @post.destroy
      redirect_to posts_url, notice: 'Post was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def owner
    if @post.author_id == @current_user.id
    else
      redirect_to login_path
      # add some flash mess instead, dont forget
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :content, :author_id, :image)
  end
end
