class SongsController < ApplicationController
  get "/songs" do
    @songs = Song.all
    erb :'songs/index'
  end
  
  get "/songs/new" do
    erb :'songs/new'
  end

  get "/songs/:slug/edit" do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end
  
  get "/songs/:slug" do
    @created = params[:created] 
    @updated = params[:updated]
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/show'
  end

  post "/songs" do 
    artist = Artist.find_by(params[:artist])
    artist = Artist.create(params[:artist]) unless !artist.nil?
    @song = Song.create(name: params[:Name], artist: artist, genre_ids: params[:genres])
    redirect to :"/songs/#{@song.slug}?created=true&updated=false", 201
  end

  patch "/songs/:slug" do
    if params[:artist]["name"] != ""
      artist = Artist.find_by(params[:artist])
      artist = Artist.create(params[:artist]) unless !artist.nil?
      Song.find_by_slug(params[:slug]).update(artist: artist)
    end
    redirect to :"/songs/#{params[:slug]}?created=false&updated=true"
  end
end
