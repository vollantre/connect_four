class Player
    attr_reader :name, :character
    def initialize(name, character)
        @name = name
        @character = character 
    end

    def get_choice
        puts "#{@name} select a column to drop your piece"
        choice = gets.chomp.to_i
        until choice.between?(1,7)
            puts "Invalid input, try again."
            choice = gets.chomp.to_i
        end
        choice
    end
end