class Board
    attr_accessor :positions
    def initialize
        @positions = Array.new(6) { Array.new(7, " ") }
    end

    def display
        rows
        @positions.each_index do |x|
            print "#{x+1}  "
            @positions[x].each_index do |y|
                print "| #{@positions[x][y]}  "
            end
            puts "|"
            rows
        end
        print "   "
        (0..6).each {|number| print "  #{number+1}  " }
        puts ""
    end

    def rows
        print "   "
        7.times { print "+----" }
        puts "+"
    end

    def full?
        @positions.each do |row|
            row.each {|x| return false if x == " "}
        end
        true
    end
end