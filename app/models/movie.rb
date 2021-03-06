class Movie < ActiveRecord::Base
	def self.all_ratings
		['G','PG','PG-13','R','NC-17']
	end
	def self.filter_by_ratings(ratings)
		ratings.collect{|rating| self.where(:rating => rating)}.first
	end
end