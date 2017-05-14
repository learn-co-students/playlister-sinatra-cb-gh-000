require 'rack-flash'

class SongsController < ApplicationController
  use Rack::Flash
  enable :sessions
  set :views, Proc.new { File.join(root, "../views/songs/") }

  get '/songs' do
    @songs = Song.all
    erb :index
  end

  post '/songs' do
    @song = Song.create(name: params[:song][:name])
    @song.update(genres: Genre.find(params[:song][:genres]))

    unless params[:artist][:name].empty?
      @artist = Artist.find_or_create_by(name: params[:artist][:name])
      @artist.songs << @song
    end

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :new
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :edit
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :show
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @song.update(name: params[:song][:name])
    @song.update(genres: Genre.find(params[:song][:genres]))

    unless params[:artist][:name].empty?
      @artist = Artist.find_or_create_by(name: params[:artist][:name])
      @artist.songs << @song
    end

    flash[:message] = "Successfully updated song."
    redirect to("/songs/#{@song.slug}")
  end
end