class Game 
  attr_accessor :board, :player_1, :player_2
  
  WIN_COMBINATIONS = 
[[0, 1, 2],
[3, 4, 5], 
[6, 7, 8], 
[0, 3, 6], 
[1, 4, 7],
[2, 5, 8],
[0, 4, 8],
[2, 4, 6]] 


def initialize (player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
  @player_2 = player_2 
  @player_1 = player_1 
  @board = board 
end

def current_player
  if @board.turn_count % 2 == 0 
    return player_1
  else 
    return player_2
  end 
end

def won? 
  WIN_COMBINATIONS.each do |win_combination|
  win_index_1 = win_combination[0]
  win_index_2 = win_combination[1]
  win_index_3 = win_combination[2]
  position_1 = @board.cells[win_index_1]
  position_2 = @board.cells[win_index_2]
  position_3 = @board.cells[win_index_3] 
  if position_1 == "X" && position_2 == "X" && position_3 == "X" || position_1 == "O" && position_2 == "O" && position_3 == "O"
  return  win_combination
  end
end
return false
end

def draw?
  if !won?  && @board.full?
    return true
  end
 return false 
end

def over?
  if won? || @board.full? || draw?
    return true
  end
  return false
end

def winner
  if won?
   exes = @board.cells.select {|number| number == "X"}
   ohs = @board.cells.select {|number| number == "O"}
   
   if exes.count <= ohs.count
     return "O"
   else 
     return "X"
    end
   end
 return nil 
end

 def turn 
   player = current_player
   puts "Please enter 1-9:"
   user_input = player.move(board)
   if @board.valid_move?(user_input)
     @board.update(user_input, player)
   else 
     turn 
   end
 @board.display
end 



 def play
  turn until over?
if won?
  puts "Congratulations " + winner + "!"
  
else 
  puts "Cat's Game!"
end
end

end 