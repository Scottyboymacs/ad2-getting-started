class MoviesController < ApplicationController
  
  def new
    @movie = Movie.new
    render template: "movies/new"
  
  end

  def edit
    @movie = Movie.where(id: params.fetch(:id))[0]
    render template: "movies/edit"
  end

  def index
    matching_movies = Movie.all

    @list_of_movies = matching_movies.order({ :created_at => :desc })

    render({ :template => "movies/index.html.erb" })
  end

  def show
    the_id = params.fetch("id")

    matching_movies = Movie.where({ :id => the_id })
    # remember, we have to use [] instead of the .at method to call a specific spot in the record relationship
    @movie = matching_movies[0]

    render({ :template => "movies/show.html.erb" })
  end

  def create
    movie = Movie.new
    movie.title = params.fetch("query_title")
    movie.description = params.fetch("query_description")
    movie.released = params.fetch("query_released", false)

    if movie.valid?
      movie.save
      redirect_to("/movies", { :notice => "Movie created successfully." })
    else
      redirect_to("/movies", { :alert => movie.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("id")
    movie = Movie.where({ :id => the_id })[0]

    movie.title = params.fetch("query_title")
    movie.description = params.fetch("query_description")
    movie.released = params.fetch("query_released", false)

    if movie.valid?
      movie.save
      redirect_to("/movies/#{movie.id}", { :notice => "Movie updated successfully."} )
    else
      redirect_to("/movies/#{movie.id}", { :alert => movie.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("id")
    movie = Movie.where({ :id => the_id })[0]

    movie.destroy

    redirect_to("/movies", { :notice => "Movie deleted successfully."} )
  end
end
