require 'sinatra'
require_relative 'tateti_facade.rb'

helpers do
  def return_status()
    {gameStatus: settings.tateti_facade.game_status}.to_json
  end
end

set :tateti_facade, TatetiFacade.new

before do
  content_type :json
end

get '/gameStarted' do
  {gameStarted: settings.tateti_facade.gameStarted?}.to_json
end

get '/gameStatus' do
  return_status
end

post '/restartGame' do
  settings.tateti_facade = TatetiFacade.new
  return_status
end

post '/addPlayer' do
  settings.tateti_facade.addPlayer(params['player'].to_sym)
  return_status
end

post '/play' do
  player = params['player'].to_sym
  position = [params['x'].to_i, params['y'].to_i]
  settings.tateti_facade.play(player, position)

  return settings.tateti_facade.boardWithSymbols.to_json
end