#/spec/board_spec.rb
require './lib/board.rb'

RSpec.describe Board do
    describe "#full?" do
        before(:each) do
            @board = Board.new
        end
        it "returns true if it's full" do
            @board.positions = Array.new(6) { Array.new(7, "X") }
            expect(@board.full?).to eql(true)
        end

        it "returns false otherwise" do
            @board.positions = Array.new(6) { Array.new(7, "X") }
            @board.positions[0][5] = " "
            expect(@board.full?).to eql(false)
        end
    end
end