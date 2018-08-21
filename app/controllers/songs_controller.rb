require 'rack-flash'
class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :"songs/songs"
  end

  get '/songs/new' do
    @artists = Artist.all
    @genres = Genre.all
    erb :'songs/new'
  end

  post '/songs/new' do
    # binding.pry
    @song = Song.new(name: params[:name])
    if !!params[:genre]
      @genre = Genre.find_by(name: params[:genre][0])
    end
    if !params[:new_genre].empty?
      @genre = Genre.create(name: params[:new_genre])
    end
    if !!params[:artist]
      @artist = Artist.find_by(name: params[:artist])
    end
    if !params[:new_artist].empty?
      @artist = Artist.find_or_create_by(name: params[:new_artist])
    end
    @song.artist = @artist
    @song.genres = [@genre]
    @song.save
    # binding.pry
    # flash[:message] = "Successfully created song."
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do

    @song = Song.find_by_slug(params[:slug])
    @song.update(name: params[:name])
    @song.artist = Artist.find_or_create_by(name: params[:artist_name])
    @song.genre_ids = params[:genres]
    @song.save
    # binding.pry
    # flash[:message] = "Successfully updated song."
    redirect("/songs/#{@song.slug}")
  end


end
