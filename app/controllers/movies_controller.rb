class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index

    @all_ratings = []
    Movie.select(:rating).each do |rating|
        @all_ratings  << rating.rating
    end
    @all_ratings.uniq!

    selected_ratings = []
    if (params.has_key?(:ratings))
      @selected_ratings = params[:ratings].keys
    end

    if (params.has_key?(:sorted_by))
      @movies = Movie.where(:rating => @selected_ratings).order(params[:sorted_by])
      @sort = params[:sorted_by]
    else
      @movies = Movie.where(:rating => @selected_ratings) 
    end

  end


  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
