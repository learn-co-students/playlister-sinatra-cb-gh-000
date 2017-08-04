class ApplicationController < Sinatra::Base

  register Sinatra::ActiveRecordExtension
  enable :sessions
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }


  get '/' do
    erb :index
  end

  helpers do
    def find_song(slug)
      Song.find_by_slug(slug)
    end
  end
end
