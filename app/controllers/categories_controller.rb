class CategoriesController < ApplicationController

	def index
		
	end

	def dogs	
		@posts = Post.all
		@dogs = Post.where(:category_id => 1)	
	end


	def cats
		@cats = Post.where(:category_id => 2)	
	end

		def rabbits
		@rabbits = Post.where(:category_id => 3)	
	end



end
