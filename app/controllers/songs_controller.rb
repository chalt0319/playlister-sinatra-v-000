require 'pry'
class SongsController < ApplicationController

  get '/songs' do
    erb :'/songs/index'
  end

  get '/songs/:slug' do
    @song = Song.find_by_slug(params[:slug])
    erb :'/songs/show'
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
    @genre = Genre.new(name: params[:genre])
  end
end
