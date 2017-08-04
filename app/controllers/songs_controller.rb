class SongsController < ApplicationController

  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end


  get '/songs/new' do
    erb :'songs/new'
  end

  post '/songs' do

    artist = Artist.find_or_create_by(name: params[:artist_name])
    song = Song.create(name: params[:song_name], artist: artist, genre_ids: params[:genres])

    flash[:message] = 'Successfully created song.'
    redirect "/songs/#{song.slug}"
  end

  get '/songs/:slug' do
    @song = find_song(params[:slug])
    erb :'songs/show'
  end

  get '/songs/:slug/edit' do
    @song = find_song(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do

    song = find_song(params[:slug])
    if !params[:artist_name].empty?
      artist = Artist.find_or_create_by(name: params[:artist_name])
      song.artist = artist
    end
    song.genre_ids = params[:genres]
    song.save
    flash[:message] = 'Successfully updated song.'
    redirect "/songs/#{song.slug}"
  end

end