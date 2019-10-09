class SongsController < ApplicationController

    get '/songs' do 
        @all_songs = Song.all
        erb :'/songs/index'
    end
    
    get '/songs/new' do
    erb :'/songs/new'
    end

    get '/songs/:slug' do 
    @created=params[:created]
    @updated=params[:updated]
        # binding.pry
    @song = Song.find_by_slug(params["slug"])
    p params[:q]
    # if param["q"] == "create"
    #     @created = 1
    # elsif param["q"] == "update"
    #     @created = 2
    # end 
   

    # binding.pry
    erb :'/songs/show'
    end

    post '/songs' do 
    # binding.pry
    # @genres = [] => APP will not have a choice for selecting multiple genres.

    if !params["Artist Name"].empty?
        if !Artist.find_by(name: params["Artist Name"]).nil?
            @artist = Artist.find_by(name: params["Artist Name"])
        else
        @artist = Artist.create(name: params["Artist Name"])
        end
    else
        @artist = Artist.find(params["artist"])
    end

    if !params["genre_name"].empty?
        @genre = Genre.create(name: params["genre_name"])
    else
        @genre = Genre.find(params["genre"])
    end

    # params["genres"].each do |genre|
    #     @genres << genre
    # end

    @song = Song.create(name: params["Name"], artist_id: @artist.id)

    @song.song_genres.build(genre: @genre)
    @song.artist = @artist

    @artist.save
    @song.save

    redirect to "/songs/#{@song.slug}?created=true&updated=false"

    end

    get '/songs/:slug/edit' do 
        @song = Song.find_by_slug(params["slug"])
        erb :'/songs/edit'
    end

    patch '/songs/:slug' do 
        binding.pry
        @song = Song.find_by_slug(params["slug"])
        if params[:artist]["name"] != ""
        artist = Artist.find_by(name: params["artist_name"])
        artist = Artist.create(name: params["artist_name"]) unless !artist.nil?
        # @song.update(name: params["song_name"])
        @song.update(artist: artist)
        end

        redirect to "/songs/#{@song.slug}?created=false&updated=true"
    end

end