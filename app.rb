require 'sinatra'
require "sinatra/reloader"
require_relative 'lib/database_connection'
require_relative 'lib/album_repository'
require_relative 'lib/artist_repository'

DatabaseConnection.connect

class Application < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload 'lib/album_repository'
    also_reload 'lib/artist_repository'
  end


  # get '/albums' do
  #   repo = AlbumRepository.new
  #   albums = repo.all
  #   response = albums.map { |album| album.title}.join(', ')
  #   return response
  # end

  post '/albums' do
    repo = AlbumRepository.new
    @new_album = Album.new
    @new_album.title = params[:title]
    @new_album.release_year = params[:release_year]
    @new_album.artist_id = params[:artist_id]

    repo.create(@new_album)

    # return nil
    return erb(:album_confirmation)
  

  end

  # get '/artists' do
  #   repo = ArtistRepository.new
  #   artists = repo.all
  #   response = artists.map { |artist| artist.name}.join(', ')
  # end

  post '/artists' do
    repo = ArtistRepository.new
    @new_artist = Artist.new
    @new_artist.name = params[:name]
    @new_artist.genre = params[:genre]
    repo.create(@new_artist)
    # return nil
    return erb(:artist_confirmation)
  end





  get '/' do
    return erb(:all_albums)
  end


  get '/new_album' do
    return erb(:album_form)

  end





  get '/albums/:id' do
    repo = AlbumRepository.new
    @album = repo.find(params[:id])

    artist_rep = ArtistRepository.new
    @artist = artist_rep.find(@album.artist_id)

    return erb(:album)
  end

  get '/albums' do
    repo = AlbumRepository.new
    @albums = repo.all
    return erb(:all_albums)
  end


  get '/new_artist' do
    return erb(:artist_form)
  end

  get '/artists/:id' do
    repo = ArtistRepository.new
    @artist = repo.find(params[:id])
    return erb(:artist)
  end

  get '/artists' do
    repo = ArtistRepository.new
    @artists = repo.all
    return erb(:all_artists)
  end


end