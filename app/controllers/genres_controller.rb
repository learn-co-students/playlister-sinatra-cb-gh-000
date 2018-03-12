
class GenresController < ApplicationController
  get '/genres' do
    @all_genres = Genre.all
    erb :'/genres/index'
  end

  get 'genres/new' do

  end
  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    # binding.pry
    erb :'/genres/show'
  end
end