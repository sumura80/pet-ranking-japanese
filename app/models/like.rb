class Like < ApplicationRecord
	validates :user_id ,{presence: true}
	validates :post_id ,{presence: true}
	has_one :post
end
