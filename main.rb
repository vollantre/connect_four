require "./lib/game"

def start_game
    puts "Who wants to be the first player?"
    name1 = gets.chomp.capitalize
    puts "#{name1} what character do you want use?"
    char1 = gets.chomp[0].upcase
    player1 = Player.new(name1, char1)
    puts "Who wants to be the second one?"
    name2 = gets.chomp.capitalize
    puts "#{name2} what character do you want to use?\n(NOTE: you can't use the same as #{name1})"
    char2 = gets.chomp[0].upcase
    while char2 == char1
        puts "#{name1} has already use that character, try another, please."
        char2 = gets.chomp[0].upcase
    end
    player2 = Player.new(name2, char2)
    board = Board.new
    game = Game.new([player1, player2], board)
    sleep 1
    puts `clear`
    game.play
    sleep 1
    puts "Do you want to play again?\n(Y/n)"
    reply = gets.chomp[0].downcase
    start_game unless reply == "n"
    sleep 0.5
    puts "Thanks for playing!, I hope see you again."
end

start_game