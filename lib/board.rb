require_relative 'redis_model'

module Tateti
  class Board < RedisModel
    Left_right_diagonal_positions = [[0,0], [1,1], [2,2]]
    Right_left_diagonal_positions = [[0,2], [1,1], [2,0]]

    redis_attr_accessor :board, :winner, :turn, :next_player

    def initialize(id)
      super id
      if REDIS.exists("#{self.class.name}:#{id}") == 0
        self.board ||= Array.new(3) { Array.new(3, :empty_square)}
        self.turn ||= 0
        self.winner ||= nil

        self.next_player = 0
      end

      super id
    end

    def was_winning_move?(position)
      position_x, position_y = position
      player = board[position_x][position_y]
      
      #Si todas las posiciones de la fila son iguales, gano.
      if board[position_x].uniq.size <= 1 then 
        return player 
      end
      
      column = [board[0][position_y], board[1][position_y], board[2][position_y]]
      if column.uniq.size <= 1 then return player end

      if Left_right_diagonal_positions.include?(position) 
        left_righ_diagonal = Array.new(3) { |i| board[i][i] }
        if left_righ_diagonal.uniq.size <= 1 then return player end
      end

      if Right_left_diagonal_positions.include?(position) 
        right_left_diagonal = [board[0][2], board[1][1], board[2][0]]
        if right_left_diagonal.uniq.size <= 1 then return player end
      end

      return nil
    end

    def play(player, position)
      position_x, position_y = position

      raise BoardError.new("Invalid square <#{ position.join(", ") }>")  unless position_x.between?(0, 2) and position_y.between?(0, 2)
      raise BoardError.new("The square <#{ position.join(", ") }> is already occupied") unless board[position_x][position_y] == :empty_square
      raise BoardError.new("It's not player <#{ player }> turn to play") if player != next_player
      raise BoardError.new("Game ended") if winner
      
      new_board = self.board
      new_board[position_x][position_y] = player
      self.board = new_board

      if turn >= 4 #Primer turno en el que alguien puede ganar
        self.winner = was_winning_move?(position)
      end

      self.next_player = (next_player == 0 ? 1 : 0)
      self.turn += 1

      return winner
    end

    def ended?
      if winner then return true else false end
    end

    def print_board
      current_board = board
      current_board.map do |row|
        row.map do |square|
          square.to_s
        end
      end
    end
  end
end

class BoardError < StandardError
end
