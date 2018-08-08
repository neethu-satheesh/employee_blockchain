# frozen_string_literal: true

class PostsController < ApplicationController
  def index
    @posts = Post.where(user_id: current_user.id).page(params[:page]).per(10)
  end

  # def new
  #   @post = Post.new
  # end

  # def create
  #   @post = Post.new(post_params)
  #   if @post.save
  #     flash[:notice] = 'Post created successfully'
  #     redirect_to post_path(@post)
  #   else
  #     flash[:alert] = @post.errors.full_messages.to_sentence
  #     render :new
  #   end
  # end

  def show
    @post = Post.where(id: params[:id], user_id: current_user.id).first
    redirect_to posts_path if @post.blank?
  end

  # def edit
  #   @post = Post.where(id: params[:id], user_id: current_user.id).first
  #   redirect_to posts_path if @post.blank?
  # end

  # def update
  #   @post = Post.where(id: params[:id], user_id: current_user.id).first
  #   redirect_to :index if @post.blank?
  #   if @post.update_attributes(post_params)
  #     flash[:notice] = 'Post updated successfully'
  #     redirect_to post_path(@post)
  #   else
  #     flash[:alert] = @post.errors.full_messages.to_sentence
  #     render :edit, id: @post.id
  #   end
  # end

  # def destroy
  #   @post = Post.where(id: params[:id], user_id: current_user.id).first
  #   redirect_to :index if @post.blank?
  #   if @post.destroy
  #     flash[:notice] = 'Post deleted successfully'
  #     redirect_to posts_path
  #   else
  #     flash[:alert] = @post.errors.full_messages.to_sentence
  #     render :show
  #   end
  # end

  private

  def post_params
    params.require(:post)
          .permit(:request_type, :request)
          .merge(user_id: current_user.id)
  end
end
