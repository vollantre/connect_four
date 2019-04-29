#/spec/game_spec.rb
require './lib/game'
require './lib/graph'

RSpec.describe Game do
    describe "#switch_turn" do
        it "Return the player who will play the current turn" do
            player1 = double("player1")
            player2 = double("player2")
            allow(player1).to receive(:name) { "Diego" }
            allow(player2).to receive(:name) { "Jose" }
            players = [player1, player2]
            board = double("board")
            allow(board).to receive(:positions) { Array.new(6) { Array.new(7, "X") } }
            game = Game.new(players, board)
            game.switch_turn
            expect(game.current_player.name).to eql("Jose")
        end
    end

    describe "#is_full?" do
        it "Returns true if a column is full" do
            board = double("board")
            allow(board).to receive(:positions) { Array.new(6) { Array.new(7, "X") } }
            game = Game.new([1,2], board)
            expect(game.is_full?(5)).to eql(true)
        end

        it "Returns false otherwise" do
            board = double("board")
            allow(board).to receive(:positions) { Array.new(6) { Array.new(7, " ") } }
            game = Game.new([1,2], board)
            expect(game.is_full?(3)).to eql(false)
        end
    end

    describe "#drop_piece" do
        context "The column selected isn't full" do
            it "Fills the column selected" do
                board = double("board")
                allow(board).to receive(:positions).and_return(Array.new(6) { Array.new(7, " ") })
                game = Game.new([1,2], board)
                game.drop_piece(7, "X")
                expect(board.positions[5][6]).to eql("X")
            end
        end

        context "The column has one or more items inside but isn't full" do
            it "Still fills the column selected" do
                board = double("board")
                allow(board).to receive(:positions).and_return(Array.new(6) { Array.new(7, " ") })
                game = Game.new([1,2], board)
                board.positions[5][6] = "O"
                game.drop_piece(7, "X")
                expect(board.positions[5][6]).to eql("O")
                expect(board.positions[4][6]).to eql("X")
                game.drop_piece(7,"O")
                expect(board.positions[3][6]).to eql("O")
            end
        end

        context "The column selected is full" do
            it "does nothing" do
                board = double("board")
                allow(board).to receive(:positions).and_return(Array.new(6) { Array.new(7, "O")} )
                game = Game.new([1,2], board)
                game.drop_piece(7, "X")
                expect(board.positions[0][6]).to eql("O")
            end
        end
    end

    describe "#generate_graph" do
        before(:each) do
            board = double("board")
            allow(board).to receive(:positions).and_return(Array.new(6) { Array.new(7, " ") })
            @game = Game.new([1,2], board)
        end
        it "return a graph" do
            expect(@game.generate_graph([[1,0],[-1,0]])).to be_instance_of(Graph)
        end
    end
end

