#spec/graph_spec.rb
require './lib/graph'

RSpec.describe Graph do
    before(:each) do
        @graph = Graph.new
    end

    describe "#add_vertex" do
        it "adds a new vertex to the graph" do
            vertex = double('vertex')
            allow(vertex).to receive(:value) { [1,5] }
            @graph.add_vertex(vertex)
            expect(@graph.vertices).to include(vertex.value => vertex)
        end
    end

    describe "#add_edge" do
        it "call the #add_edge in each of the two vertices passed as arguments" do
            vertex1 = Vertex.new([1,2])
            vertex2 = Vertex.new([2,5])

            @graph.add_vertex(vertex1)
            @graph.add_vertex(vertex2)

            @graph.add_edge(vertex1, vertex2)
            expect(vertex1.neighbors).to include(vertex2.value)
            expect(vertex2.neighbors).to include(vertex1.value)
        end
    end
end

RSpec.describe Vertex do
    before(:each) do
        @vertex = Vertex.new([0,1])
    end

    describe "#add_edge" do
        it "add a new neighbour to the actual instance" do
            @vertex.add_edge([1,2])
            expect(@vertex.neighbors.size).to eql(1)
        end
    end

    describe "#equal_to_neighbors?" do
        it "return true if the neighbors are equal to the actual vertex" do
            ary = Array.new(3) { Array.new(3, " ") }
            ary.each { |x| x[0] = "Y" }
            @vertex.add_edge([0,0])
            @vertex.add_edge([2,0])
            @vertex.value = [1,0]
            expect(@vertex.equal_to_neighbors?(ary, "Y")).to eql(true)
        end

        it "return false otherwise" do
            ary = Array.new(3) { Array.new(3, " ") }
            ary.each { |x| x[0] = "Y" }
            @vertex.add_edge([0,0])
            @vertex.add_edge([2,0])
            @vertex.value = [1,0]
            ary[2][0] = " "
            expect(@vertex.equal_to_neighbors?(ary, "Y")).to eql(false)
        end
    end
end
