require 'rack-flash'

class SongsController < ApplicationController
  enable :sessions
  use Rack::Flash
  get '/songs' do
    @all_songs = Song.all
    erb :'/songs/index'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/edit'
  end

  patch '/songs/:slug' do
    # binding.pry
    artist =  Artist.find_or_create_by(name: params[:artist_name])
    @song = Song.find_by_slug(params[:slug])
    @song.update(params[:song])
    @song.artist = artist
    @song.save

    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/new' do
    erb :'songs/new'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  post '/songs' do
      artist =  Artist.find_or_create_by(name: params[:artist_name])
      @song = Song.new(params[:songs])
      @song.artist = artist
      @song.save
    params[:genre_id].each {|gid| SongGenre.create(song_id: @song.id, genre_id: gid)}

      flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

end