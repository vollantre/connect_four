class Vertex
    attr_accessor :neighbors, :value
    def initialize(value)
        @value = value
        @neighbors = []
    end

    def add_edge(neighbour)
        @neighbors << neighbour
    end

    def equal_to_neighbors?(positions, char)
        if @neighbors.length > 1
            @neighbors.all? { |x|  positions[x[0]][x[1]] == char && char == positions[@value[0]][value[1]] }
        end
    end
end


class Graph
    attr_reader :vertices
    def initialize
        @vertices = {}
    end

    def add_vertex(vertex)
        @vertices[vertex.value] = vertex
    end

    def add_edge(vertex1, vertex2)
        @vertices[vertex1.value].add_edge(vertex2.value)
        @vertices[vertex2.value].add_edge(vertex1.value)
    end

    def line?(pos, char)
        @vertices.each_value do |vertex|
            vertex.neighbors.each {|x| return true if (vertex.equal_to_neighbors?(pos, char) && @vertices[x].equal_to_neighbors?(pos, char))}
        end
        false
    end
end