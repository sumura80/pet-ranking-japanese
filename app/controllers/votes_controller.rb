class VotesController < ApplicationController
	  # before_actionに「:authenticate_user」を追加
  before_action :authenticate_user!, only:[:create,:destroy]


  # createアクションを追加
  def create
    @vote = Vote.new(user_id: current_user.id,  comment_id: params[:comment_id])
    @post_id = @vote.comment.post.id
    @vote.save
    # 投稿詳細ページにリダイレクト
    redirect_back(fallback_location: post_path(@post_id))
  end

    # destroyアクションを定義
  def destroy
    @vote = Vote.find_by(user_id: current_user.id)
    @post_id = @vote.comment.post.id
    @vote.destroy
    redirect_back(fallback_location: post_path(@post_id))
  end
end
