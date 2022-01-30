require_relative 'board.rb'

class Match < RedisModel
  redis_attr_accessor :player0, :player1, :status, :winner, :board_id
  attr_accessor :board

  def initialize(id)
    super id
    self.board = board_id && Board.new(board_id)
  end
  
  def gameStarted?
    if board then return true else return false end
  end

  def addPlayer(player)
    raise MatchError.new("Game already started") if board_id

    if !player0 
      self.player0 = player
      self.status = "Waiting for second player."
    else
      self.player1 = player
      self.board_id = id
      self.board = Board.new(board_id)
      self.status = "Game ready."
    end
    
    return status
  end

  def play(player, position)
    player_number = (player == player0) ? 0 : 1
    winner = board.play(player_number, position)
    if winner then
      self.status = "Game finished, the winner is #{winner}."
    end
  end
end

class MatchError < StandardError
end
