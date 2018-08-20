class SongsController < ApplicationController

  get '/songs' do
    @songs = Song.all
    erb :"songs/songs"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end


end
