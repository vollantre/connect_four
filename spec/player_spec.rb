#/spec/player_spec.rb
require './lib/player'
require 'stringio'

RSpec.describe Player do
    describe "#get_choice" do
        let(:player) { Player.new("Diego", "X") }

        it "Ask for the column to drop piece" do
            allow(player).to receive(:gets).and_return("1\n")
            expect{player.get_choice}.to output.to_stdout
        end

        context "The player has entered a invalid number" do
            it "Send a error msg and ask for a valid input again" do
                allow(player).to receive(:gets).and_return("a\n", "1\n")
                expect{player.get_choice}.to output("Diego select a column to drop your piece\nInvalid input, try again.\n").to_stdout
            end
        end
        
        context "The player has entered a valid number" do
            it "Return the value that the player has entered" do
                allow(player).to receive(:gets).and_return("1\n")
                expect(player.get_choice).to eql(1)
            end
        end
    end
end