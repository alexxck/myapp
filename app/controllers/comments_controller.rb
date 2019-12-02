# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_post
  before_action :require_login, only: %i[create edit update destroy]
  before_action :find_comment, only: [:show,
                                      :destroy,
                                      :edit,
                                      :update,
                                      :vote,
                                      :downvote]
  before_action :owner, only: %i[edit update destroy]

  def create
    @comment = @post.comments.create(comment_params)
    @comment.author_id = current_user.id
    respond_to do |format|
      # dev, del later
      if @comment.save
        format.html { redirect_to @post, notice: 'good' }
      else
        format.html { redirect_to @post, notice: 'bad' }
      end
    end
  end

  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to @post
    else
      render 'edit'
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if (@current_user.id == @comment.author_id) || (@current_user.admin == true)
      @comment.destroy
      redirect_to post_path(@post)
      # add mess
    else
      redirect_to root_path
      # add smth instead
    end
  end

  def vote
    @comment.upvote_from current_user
    respond_to do |format|
      format.html { redirect_to @post}
    end
  end

  def downvote
    @comment.downvote_from current_user
    respond_to do |format|
      format.html { redirect_to @post }
    end
  end

  def index
    @post.comments = @post.comments.arrange(order: :created_at)
  end

  def new
    @comment = Comment.new(parent_id: params[:parent_id])
  end

  private

  def owner
    if (@comment.author_id == @current_user.id) || (@current_user.admin == true)
    else
      redirect_to login_path
      # add some flash mess instead, dont forget
    end
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body, :author_id, :post_id, :parent_id)
  end
end