class Movie < ActiveRecord::Base
	def self.all_ratings
		Movie.all.select(:rating).group(:rating).map(&:rating)
	end
	def self.filter_by_rating(rating)
		Movie.all.select(rating)
	end
end