class MoviesController < ApplicationController

	def initialize
		@all_ratings = Movie.all_ratings	
		super
	end

	def index
		session[:ratings] ||= []
		params[:ratings] ? session[:ratings] = params[:ratings] : session[:ratings] = @all_ratings
		@movies = Movie.all	
		@movies = @movies.filter_by_ratings(session[:ratings])
		@movies = @movies.order(sort_column) if sort_column
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
		respond_to do |client_wants|
			client_wants.html { flash[:notice] = "#{@movie.title} was sucessfully created"
								redirect_to movie_path(@movie)
							  }
			client_wants.xml {render :xml => @movie.to_xml}
		end
	end

	def destroy
		@movie = Movie.find(params[:id])
		@movie.destroy
		flash[:notice] = "Movie #{@movie.title} was sucessfully deleted."
		redirect_to movies_path
	end


	private

	def movie_params
		params.require(:movie).permit(:title, :ratings, :description, :release_date,:sort)
	end

	def sort_column
		%w{title, release_date}.include?(params[:sort]) ? params[:sort] : nil
	end
	
end
