require_relative 'board.rb'

class Match < RedisModel
  redis_attr_accessor :player0, :player1, :status, :winner
  attr_accessor :board
  
  def gameStarted?
    if board then return true else return false end
  end

  def addPlayer(player)
    raise TatetiFacadeError.new("Game already started") if board

    if !player0 
      player0 = player
      status = "Waiting for second player."
    else 
      player1 = player
      board = Board.new(id)
      status = "Game ready."
    end
    
    return status
  end

  def play(player, position)
    winner = board.play(player, position)
    if winner then
      status = "Game finished, the winner is #{winner}."
    end
  end
end

class TatetiFacadeError < StandardError
end
