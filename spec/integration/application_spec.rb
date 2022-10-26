require "spec_helper"
require "rack/test"
require_relative '../../app'
require 'album_repository'
require 'artist_repository'

describe Application do
  # This is so we can use rack-test helper methods.
  include Rack::Test::Methods

  # We need to declare the `app` value by instantiating the Application
  # class so our tests work.
  let(:app) { Application.new }

  before(:each) do 
    reset_artists_table
  end
  
  before(:each) do 
    reset_albums_table
  end

  # context 'GET /' do
  #   it 'returns the html index' do
  #     response = get('/')
  #     expect(response.body).to include ('<h1>Hello!</h1>')
  #   end
  # end

  # context 'GET /albums' do
  #   it 'returns the list of albums' do
  #     response = get('/albums')

  #     expected_response = 'Doolittle, Surfer Rosa, Waterloo, Super Trouper, Bossanova, Lover, Folklore, I Put a Spell on You, Baltimore, Here Comes the Sun, Fodder on My Wings, Ring Ring'
  #     expect(response.status).to eq 200
  #     expect(response.body).to eq expected_response
  #   end
  # end  

  context 'GET /new_album' do
    it 'creates an album via an html form' do
      response = get('/new_album')
      expect(response.status).to eq 200
      expect(response.body).to include ('<form action="/albums" method="POST">')
    end
  end

  context 'POST /albums' do
    it 'creates a new album' do
      response = post(
        '/albums', 
        title: 'Voyage', 
        release_year: '2022', 
        artist_id: '2'
      )
      expect(response.status).to eq 200
      # expect(response.body).to eq ''
      # response = get('/albums')
      # expect(response.body).to include('Voyage')
      expect(response.body).to include('<h1>Album created: Voyage </h1>')
    end
  end


  context 'GET /new_artist' do
    it 'creates an artists' do
      response = get('/new_artist')
      expect(response.status).to eq 200
      expect(response.body).to include ('<form action="/artists" method="POST">')
    end
  end

  context 'GET /artists' do
    it 'returns a list of artists' do
      response = get('/artists')
      # result = 'Pixies, ABBA, Taylor Swift, Nina Simone'
      expect(response.status).to eq 200
      # expect(response.body).to eq result
      expect(response.body).to include ('<h1>Artists</h1>')
      expect(response.body).to include ('<a href="/artists/1">Name: Pixies')

    end
  end

  context 'POST /artists' do
    it "creates a new artist" do
      response = post('/artists', name: 'Wild Nothing', genre: 'Indie')
      expect(response.status).to eq 200
      # expect(response.body).to eq ''

      # response = get('/artists')
      expect(response.body).to include('<h1>Artist created: Wild Nothing</h1>')
    end
  end

  context 'GET /albums/:id' do
    it 'returns the html with an album' do
      response = get('/albums/1')
      expect(response.status).to eq 200
      expect(response.body).to include
      ('<h1>Doolittle</h1>')
    end
  end

  # context 'GET /albums' do
  #   it 'returns the list of albums' do
  #     response = get('/albums')
  #     expect(response.status).to eq 200
  #     expect(response.body).to include('<div>Title: Doolittle Released: 1989</div>')
  #     # expect(response.body).to include('<h1>Albums</h1>')
  #   end
  # end  

  context 'GET /albums' do
    it 'returns the list of albums' do
      response = get('/albums')
      expect(response.status).to eq 200
      expect(response.body).to include('<h1>Albums</h1>')
      expect(response.body).to include('a href="/albums/1">Title: Doolittle')
      
    end
  end  

  context 'GET /artists/:id' do
    it 'returns the html with an artist' do
      response = get('/artists/1')
      expect(response.status).to eq 200
      expect(response.body).to include ('<h1>Pixies</h1>')
    end

    it 'returns the html with  artist with id 2' do
      response = get('/artists/2')
      expect(response.status).to eq 200
      expect(response.body).to include ('<h1>ABBA</h1>')
    end
  end



  


end