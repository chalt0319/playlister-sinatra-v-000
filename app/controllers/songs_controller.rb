require 'pry'
class SongsController < ApplicationController

  get '/songs' do
    erb :'/songs/index'
  end

  get '/songs/new' do
    erb :'/songs/new'
  end

  post '/songs/new' do
    @song = Song.new(name: params[:name])
    if !Artist.find_by(name: params[:artist])
      @artist = Artist.new(name: params[:artist])
    else
      @artist = Artist.find_by(name: params[:artist])
    end
    if !Genre.find_by(name: params[:genre])
      @genre = Genre.new(name: params[:genre])
    else
      @genre = Genre.find_by(name: params[:genre])
    end
    @song.artist = @artist
    @song.genres << @genre
    @song.save
    redirect "/songs/#{@song.slug}"
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
  end

  get '/songs/:slug/edit' do
    @song = Song.find_by_slug(params[:slug])
    erb :'songs/edit'
  end

  patch '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    if @song.name != params[:name]
      @song.name = params[:name]
    end
    if @song.artist.name != params[:artist]
      @song.artist.name = params[:artist]
    end
    if !@song.genres.include?(params[:genre])
      @songs.genres << params[:genre]
    end
    @song.save
    redirect "/songs/#{@song.slug}"
  end

end
