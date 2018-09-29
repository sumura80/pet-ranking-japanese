class LikesController < ApplicationController
  # before_actionに「:authenticate_user」を追加
  before_action :authenticate_user!, only:[:create,:destroy]
  

  # createアクションを追加
  def create
    @like = Like.new(user_id: current_user.id,  post_id: params[:post_id])
    @like.save
    # 投稿詳細ページにリダイレクト
    redirect_to("/posts/#{params[:post_id]}")
  end

    # destroyアクションを定義
  def destroy
    @like = Like.find_by(user_id: current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to("/posts/#{params[:post_id]}" )
  end

  
end
