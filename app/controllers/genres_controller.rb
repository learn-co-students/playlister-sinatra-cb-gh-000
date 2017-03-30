class GenresController < Sinatra::Base
  enable :sessions
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/genres' do
    @genres = Genre.all
    erb :'genres/index'
  end

  get '/genres/:slug' do
    @genre = Genre.find_by_slug(params[:slug])
    @artists = @genre.artists
    @songs = @genre.songs
    erb :'genres/show'
  end

end
