require_relative "graph"
require_relative "board"
require_relative "player"

class Game
    attr_accessor :board, :vertical
    attr_reader :current_player
    def initialize(players, board)
        @players = players
        @current_player = @players[0]
        @board = board
        @vertical = generate_graph([[-1,0],[1, 0]])
        @horizontal = generate_graph([[0, 1],[0,-1]])
        @left_to_right = generate_graph([[-1,-1],[1,1]])
        @right_to_left = generate_graph([[-1,1],[1,-1]])
        @end_message_game = ""
    end

    def play
        @board.display
        loop do
            reply = @current_player.get_choice
            while is_full?(reply)
                puts "That column is full, try another"
                reply = @current_player.get_choice
            end
            drop_piece(reply, @current_player.character)
            @board.display
            break if line_completed? || board_completed?
            switch_turn
        end
        puts @end_message_game
    end

    def line_completed?
        a = @board.positions
        b = @current_player.character
        if @vertical.line?(a,b) || @horizontal.line?(a,b) || @left_to_right.line?(a,b) || @right_to_left.line?(a,b)
            @end_message_game = "GAME OVER\n#{@current_player.name.capitalize} has won the game"
            return true
        end
        false
    end

    def board_completed?
        if @board.full?
            @end_message_game = "Game Over. The board got completed with no winner"
            return true
        end
        false
    end

    def switch_turn
        @current_player = (@current_player == @players[0]) ? @players[1] : @players[0]
    end

    def is_full?(column)
        @board.positions[0][column-1] != " "
    end

    def drop_piece(column, char)
        i = @board.positions.length-1
        while i >= 0
            if @board.positions[i][column-1] == " "
                @board.positions[i][column-1] = char
                break
            end
            i -= 1
        end
    end

    def generate_graph(directions)
        graph = Graph.new
        @board.positions.each_index do |row|
            @board.positions[row].each_index do |column|
                vertex = Vertex.new([row,column])
                directions.each do |direction|
                    x = direction[0] + vertex.value[0]
                    y = direction[1] + vertex.value[1]
                    if x.between?(0,5) && y.between?(0,6)
                        vertex.add_edge([x,y]) unless vertex.neighbors.include?([x,y])
                    end
                end
                graph.add_vertex(vertex)
            end
        end
        graph
    end
end