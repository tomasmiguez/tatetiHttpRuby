require_relative 'tateti.rb'

class TatetiFacade
  attr_reader :tateti
  attr_reader :player1
  attr_reader :player2
  attr_reader :game_status
  attr_reader :winner

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
    end
    
    return @game_status
  end

  def boardWithSymbols()
    @tateti.board.map { |row| 
                        row.map { |square| 
                                  if square == @player1 then
                                    "X"
                                  elsif square == @player2 then
                                    "O"
                                  else
                                    square
                                  end
                                }
                      }
  end

  def play(player, position)
    @winner = @tateti.play(player, position)
    if @winner then
      @game_status = "Game finished, the winner is #{@winner}."
    end
  end
end

class TatetiFacadeError < StandardError
end