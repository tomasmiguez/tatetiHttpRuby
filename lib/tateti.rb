class Tateti
  Left_right_diagonal_positions = [[0,0], [1,1], [2,2]]
  Right_left_diagonal_positions = [[0,2], [1,1], [2,0]]

  attr_reader :board
  attr_reader :winner
  attr_reader :turn

  def initialize(player1: 0, player2: 1)
    @board = Array.new(3) { Array.new(3, :empty_square)}
    @turn = 0
    @winner = nil

    @player1 = player1
    @player2 = player2
    @next_player = @player1
  end

  def was_winning_move?(position)
    position_x, position_y = position
    player = @board[position_x][position_y]
    
    #Si todas las posiciones de la fila son iguales, gano.
    if @board[position_x].uniq.size <= 1 then 
      return player 
    end
    
    column = [@board[0][position_y], @board[1][position_y], @board[2][position_y]]
    if column.uniq.size <= 1 then return player end

    if Left_right_diagonal_positions.include?(position) 
      left_righ_diagonal = Array.new(3) { |i| @board[i][i] }
      if left_righ_diagonal.uniq.size <= 1 then return player end
    end

    if Right_left_diagonal_positions.include?(position) 
      right_left_diagonal = [@board[0][2], @board[1][1], @board[2][0]]
      if right_left_diagonal.uniq.size <= 1 then return player end
    end

    return nil
  end

  def play(player, position)
    position_x, position_y = position

    raise TatetiError.new("Invalid square <#{ position.join(", ") }>")  unless position_x.between?(0, 2) and position_y.between?(0, 2)
    raise TatetiError.new("The square <#{ position.join(", ") }> is already occupied") unless @board[position_x][position_y] == :empty_square
    raise TatetiError.new("It's not player <#{ player }> turn to play") if player != @next_player
    raise TatetiError.new("Game ended") if @winner

    board[position_x][position_y] = player

    if @turn >= 4 #Primer turno en el que alguien puede ganar
      @winner = was_winning_move?(position)
    end

    @next_player = @next_player == @player1 ? @player2 : @player1
    @turn += 1
  end

  def ended?
    if @winner then return true else false end
  end

end


class TatetiError < StandardError
end
