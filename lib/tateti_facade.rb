require 'tateti'

class TatetiFacade
  attr_reader :tateti
  attr_reader :player1
  attr_reader :player2

  def initialize
    @tateti = nil
  end

  def gameStarted?
    if @tateti then return true else return false end
  end

  def addPlayer(player)
    raise TatetiFacadeError.new("Game already started") if @tateti

    if !@player1 then @player1 = player
    else 
      @player2 = player
      @tateti = Tateti.new(player1: @player1, player2: @player2)
    end
  end
end

class TatetiFacadeError < StandardError
end