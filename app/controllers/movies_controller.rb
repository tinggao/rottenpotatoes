class MoviesController < ApplicationController
	def index
		@movies = Movie.all
		sort = params[:sort] || session[:sort]
		sort == 'title' ? ordering = {:order => :title} : ordering = {:order => :release_date}
	end

	def edit		
		@movie = Movie.find(params[:id])
	end

	def update
	  @movie = Movie.find params[:id]
	  @movie.update_attributes!(movie_params)
	  flash[:notice] = "#{@movie.title} was successfully updated."
	  redirect_to movie_path(@movie)
	end

	def show
		id = params[:id]
		@movie = Movie.find(id)
	rescue ActiveRecord::RecordNotFound
		flash[:notice] = "movie with id #{id} does not exist"
		redirect_to movies_path
	end

	def new
	end

	def create		
		@movie = Movie.new(movie_params)
		@movie.save!
		flash[:notice] = "#{@movie.title} was sucessfully created"
		redirect_to movie_path(@movie)
	end

	def destroy
	  @movie = Movie.find(params[:id])
	  @movie.destroy
	  flash[:notice] = "Movie #{@movie.title} was sucessfully deleted."
	  redirect_to movies_path
	end

	private

	def movie_params
		params.require(:movie).permit(:title, :rating, :description, :release_date,:sort)
	end

	
end
