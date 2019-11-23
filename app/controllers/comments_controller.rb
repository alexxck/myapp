# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :find_post

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment].permit(:name, :body))
    @comment.author_id = current_user.id
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @post, notice: 'good' }
      else
        format.html { redirect_to @post, notice: 'bad' }
      end
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end

  private

  def find_post
    @post = Post.find(params[:post_id])
  end

  def find_comment
    @comment = @post.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:comment, :author_id, :name)
  end
end
