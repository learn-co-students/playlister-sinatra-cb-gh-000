require 'rack-flash'
class ApplicationController < Sinatra::Base
  register Sinatra::ActiveRecordExtension

  use Rack::Flash
  enable :sessions
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/' do
    "Welcome"
  end

  get '/songs/new' do
    @genres = Genre.all
    erb :new_song
  end

  get '/songs/:slug/edit' do
    @genres = Genre.all
    @song = Song.find_by_slug(params[:slug])
    erb :edit_song
  end

  get '/:domain' do
    @objects = formed_domain.all
    erb :index
  end

  get '/:domain/:slug' do
    @object = formed_domain.find_by_slug(params[:slug])
    domain_show_router
  end

  post '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    @artist = find_or_create_by_name params[:artist_name]
    genres = []
    params[:genre_ids].each do |id|
      genres << Genre.find(id)
    end
    @song.genres = genres
    @song.artist = @artist
    @song.save
    flash[:message] = "Successfully updated song."
    redirect to "/songs/#{@song.slug}"
  end

  post '/songs' do
    @song = Song.new(
      name: params[:song_name],
    )
    @artist = find_or_create_by_name params[:artist_name]
    @song.add_genres_by_id params[:genre_ids]
    @song.artist = @artist
    @song.save
    flash[:message] = "Successfully created song."
    redirect to "/songs/#{@song.slug}"
  end



  private

  def find_or_create_by_name artist_name
    Artist.find_by(name: artist_name) || Artist.create(name: artist_name)
  end

  def formed_domain
    params[:domain][0..(-2)].capitalize.constantize
  end

  def domain_show_router
    case params[:domain]
    when 'artists'
      @artist = @object
      erb :show_artist
    when 'songs'
      @song = @object
      @artist = @song.artist
      erb :show_song
    when 'genres'
      @genre = @object
      erb :show_genre
    end
  end

end
