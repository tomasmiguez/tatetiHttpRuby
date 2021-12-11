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

    raise TatetiError.new("It's not player <#{ player }> turn to play") if player != @next_player

    raise TatetiError.new("The square <#{ position.join(", ") }> is already occupied") unless @board[position_x][position_y] == :empty_square

    board[position_x][position_y] = player

    @next_player = (@next_player + 1) % 2
  end

end

class TatetiError < StandardError
end