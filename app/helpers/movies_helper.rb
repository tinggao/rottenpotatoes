module MoviesHelper
	def sort_by_title(movies)
		movies.sort_by &:title
	end
end