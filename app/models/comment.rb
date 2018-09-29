class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user
  has_many :votes

  # モデルのスコープ機能とは、共通的に使うクエリをモデルのメソッドのように定義できる機能です。
  # こうすることにより、複雑なSQLを何度も書かなくてよくなり、可読性と保守性を向上させることができます。
  # クエリとは、簡単にいうとターミナルやコマンドプロンプトに表示されるSQLのことだと考えてもらって問題ないです。
  # ここでvotesの数で並び替える処理をscopeとして定義している。
  scope :order_by_voute_count, ->  { eager_load(:votes).group("comments.id").order('count(votes.id) desc') }
  # eager_loadは外部結合ができるメソッドです。
end
