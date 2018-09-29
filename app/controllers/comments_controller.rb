class CommentsController < ApplicationController
	before_action :find_post
	before_action :find_comment ,only:[:show, :edit, :update, :destroy]
	before_action :authenticate_user!

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(post_params)
		@comment.user_id = current_user.id

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end



 	def destroy
 		@comment.destroy
 		redirect_to post_path(@post)
 	end


	private

	def post_params
		params.require(:comment).permit(:content)
	end

	def find_post
		@post = Post.find(params[:post_id])

	end

	def find_comment
		@comment = @post.comments.find(params[:id])
	end


end
