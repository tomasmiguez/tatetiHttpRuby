require 'sinatra'
require_relative 'tateti_facade.rb'

def initialize
  super()
  @tateti_facade = TatetiFacade.new
end

before do
  content_type :json
end

get '/gameStarted/?' do
  {gameStarted: @tateti_facade.gameStarted?}.to_json
end

post '/addPlayer' do
  {gameStatus: @tateti_facade.addPlayer(params['player'].to_sym)}.to_json
end