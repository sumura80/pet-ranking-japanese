class PostsController < ApplicationController
	before_action :find_post ,only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except:[:index, :show]

  def index
    if params[:category].blank?
    	@posts = Post.all.order("created_at DESC")
    else
      @category_id = Category.find_by(name: params[:category]).id
      @posts = Post.where(:category_id => @category_id)
    end
  end

  def show
    @post = Post.find_by(id: params[:id])
    @comments = @post.comments
    
    

    # 変数@likes_countを定義
    #モデルにリレーションを作ることでLikes.findなどとアクセスしなくても
    #以下の形でpostに紐づくlikeのレコードを取得することができる。
    #また、countメソッドを使うとレコードがない場合に0となってしまうので、countはviewで描画時に行う。
    #Railsでは0の扱いが難しいため。

    #⬇︎サインインしてない = current_userがnilなので、エラーになってしまう。⬇︎
    #@likes_count = Like.where(post_id: @post.id).count
    @likes = @post.likes
      
    #ruby on railsだけではなく、SQLの知識も必要です。
    # order_by_voutes_countはcommet.rb つまりmodeleで定義した
    # scopeを実行しているものです。scopeについてはmodel側のソースコード
    # で簡単に説明しています。
    @comments_by_votes = @post.comments.order_by_voute_count
   
    #自分がいいね！したレコードがあるかどうかのチェック。
    #current_user&.idの&(アンパサンド)がないとcurrent_userがnilのときにエラーがおきる。
    @my_like = @likes.find_by_user_id(current_user&.id)
		# @my_votes = Vote.where(user_id:current_user.id, comment_id:@post.comments.ids)
  end

  def new
  	@post = current_user.posts.build
    @categories = Category.all.map{ |c| [c.name, c.id]}

  end

  def create
  	@post = current_user.posts.build(post_params)
    @post.category_id = params[:category_id]

  	if @post.save
  		redirect_to post_path(@post)
  	else
  		render 'new'
  	end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id]}
  end

  def update
    @post.category_id = params[:category_id]
  	if @post.update(post_params)
  		redirect_to post_path
  	else
  		render 'edit'
  	end
  end

  def destroy
  	@post.destroy
  	redirect_to root_path
  end



  private
  def post_params
  	params.require(:post).permit(:id, :title, :description, :image, :category_id)
  end

  def find_post
  	@post = Post.find(params[:id])
  end

end
