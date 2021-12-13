require_relative 'tateti.rb'

class TatetiFacade
  attr_reader :tateti
  attr_reader :player1
  attr_reader :player2
  attr_reader :game_status

  def initialize
    @game_status = "Waiting for players."
  end

  def gameStarted?
    if @tateti then return true else return false end
  end

  def addPlayer(player)
    raise TatetiFacadeError.new("Game already started") if @tateti

    if !@player1 
      @player1 = player
      @game_status = "Waiting for second player."
    else 
      @player2 = player
      @tateti = Tateti.new(player1: @player1, player2: @player2)
      @game_status = "Game ready."
    
    return @game_status
  end
end

class TatetiFacadeError < StandardError
end