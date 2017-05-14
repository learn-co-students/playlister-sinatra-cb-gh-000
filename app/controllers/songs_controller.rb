require 'sinatra/base'
require 'rack-flash'

class SongsController < Sinatra::Base
  register Sinatra::ActiveRecordExtension
  use Rack::Flash
  enable :sessions
  set :views, Proc.new { File.join(root, "../views/songs/") }



  get '/songs' do
    @songs = Song.all
    erb :index
  end

  post '/songs' do
    @song = Song.create(name: params[:song][:name])

    unless params[:artist][:name].empty?
      @artist = Artist.find_or_create_by(name: params[:artist][:name])
      @artist.songs << @song
    end

    params[:genres].each do |genre_id|
      @song.genres << Genre.find(genre_id)
    end

    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :new
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :show
  end
end