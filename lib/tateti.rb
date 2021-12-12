class Tateti
  attr_reader :board
  attr_reader :next_player

  def initialize
    @board = Array.new(3) { Array.new(3, :empty_square)}
    @next_player = 0
  end

  def play(player, position)
    position_x, position_y = position

    raise TatetiError.new("Invalid square <#{ position.join(", ") }>")  unless position_x.between?(0, 2) and position_y.between?(0, 2)
    raise TatetiError.new("The square <#{ position.join(", ") }> is already occupied") unless @board[position_x][position_y] == :empty_square
    raise TatetiError.new("It's not player <#{ player }> turn to play") if player != @next_player

    board[position_x][position_y] = player

    @next_player = (@next_player + 1) % 2
  end

  def ended?
    if @board.any?([0, 0, 0]) or @board.any?([1, 1, 1]) then return true end
    
    for i in (0..2)
      column = [@board[0][i], @board[1][i], @board[2][i]]

      if column == [0, 0, 0] or column == [1, 1, 1] then return true end
    end

    left_righ_diagonal = [@board[0][0], @board[1][1], @board[2][2]]
    if left_righ_diagonal == [0, 0, 0] or left_righ_diagonal == [1, 1, 1] then return true end
    
    right_left_diagonal = [@board[0][2], @board[1][1], @board[2][0]]
    if right_left_diagonal == [0, 0, 0] or right_left_diagonal == [1, 1, 1] then return true end

    return false
  end

end

class TatetiError < StandardError
end