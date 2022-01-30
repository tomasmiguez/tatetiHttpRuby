
[1mFrom:[0m /home/tmiguez/repos/tatetiHttpRuby/lib/board.rb:64 Tateti::Board#play:

    [1;34m48[0m: [32mdef[0m [1;34mplay[0m(player, position)
    [1;34m49[0m:   position_x, position_y = position
    [1;34m50[0m: 
    [1;34m51[0m:   raise [1;34;4mBoardError[0m.new([31m[1;31m"[0m[31mInvalid square <#{ position.join([1;31m"[0m[31m, [1;31m"[0m[31m[0m[31m) }[0m[31m>[1;31m"[0m[31m[0m)  [32munless[0m position_x.between?([1;34m0[0m, [1;34m2[0m) [32mand[0m position_y.between?([1;34m0[0m, [1;34m2[0m)
    [1;34m52[0m:   raise [1;34;4mBoardError[0m.new([31m[1;31m"[0m[31mThe square <#{ position.join([1;31m"[0m[31m, [1;31m"[0m[31m[0m[31m) }[0m[31m> is already occupied[1;31m"[0m[31m[0m) [32munless[0m board[position_x][position_y] == [33m:empty_square[0m
    [1;34m53[0m:   raise [1;34;4mBoardError[0m.new([31m[1;31m"[0m[31mIt's not player <#{ player }[0m[31m> turn to play[1;31m"[0m[31m[0m) [32mif[0m player != next_player
    [1;34m54[0m:   raise [1;34;4mBoardError[0m.new([31m[1;31m"[0m[31mGame ended[1;31m"[0m[31m[0m) [32mif[0m winner
    [1;34m55[0m:   
    [1;34m56[0m:   new_board = [1;36mself[0m.board
    [1;34m57[0m:   new_board[position_x][position_y] = player
    [1;34m58[0m:   [1;36mself[0m.board = new_board
    [1;34m59[0m: 
    [1;34m60[0m:   [32mif[0m turn >= [1;34m4[0m [1;34m#Primer turno en el que alguien puede ganar[0m
    [1;34m61[0m:     [1;36mself[0m.winner = was_winning_move?(position)
    [1;34m62[0m:   [32mend[0m
    [1;34m63[0m: 
 => [1;34m64[0m:   binding.pry
    [1;34m65[0m:   [1;36mself[0m.next_player = (next_player == [1;34m0[0m ? [1;34m1[0m : [1;34m0[0m)
    [1;34m66[0m:   [1;36mself[0m.turn += [1;34m1[0m
    [1;34m67[0m: 
    [1;34m68[0m:   [32mreturn[0m winner
    [1;34m69[0m: [32mend[0m

