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
    @posts = Post.all.order('created_at DESC')
    @posts = if params[:search]
               Post.search(params[:search]).order('created_at DESC')
             else
               Post.all.order('created_at DESC')
             end
    # @posts = Post.paginate(page: params[:page])
    @posts = []
    Post.all.each do |post|
      @posts.push(post)
    end
    @posts = @posts.paginate(page: params[:page], per_page: 8)
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
    @post = current_user.posts.build(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    redirect_to root_path if owner == false
    respond_to do |format|
      if @post.update_attributes(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  def owner
    if (@post.author_id == @current_user.id) || (@current_user.admin == true)
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
