require 'rack-flash'
class SongsController < Sinatra::Base
  enable :sessions
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }
  use Rack::Flash

  get '/songs' do
    @songs = Song.all
    erb :'songs/index'
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :'songs/edit'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = @song.artist
    @genres = @song.genres
    erb :'songs/show'
  end

  put '/songs' do
    artist = Artist.find_or_create_by(name: params["artist"]["name"])
    params["song"]["artist"] = artist
    song = Song.create(params["song"])
    if song
      flash[:message] = "Successfully created song."
      redirect "/songs/#{song.slug}"
    else
      redirect '/'
    end
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    @genres = Genre.all
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    artist = Artist.find_or_create_by(name: params["artist"]["name"])
    song = Song.find_by_slug(params[:slug])
    params["song"]["artist"] = artist
    if song.update(params["song"])
      flash[:message] = "Successfully updated song."
      redirect "/songs/#{song.slug}"
    else
      redirect '/'
    end
  end

end
