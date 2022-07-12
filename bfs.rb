module BFS
  #  0 <= end_node
  # start_node < num_of_nodes
  def bfs(start_node, end_node)
      num_of_nodes = nil
      # g = adjacency list representing unweighted graph
      # unweighted means the graph nodes do not have a numerical value

      prev = solve(start_node)


      return reconstruct_path(start_node, end_node, prev)
  end

  def solve(start_node, num_of_nodes)
      # initialize queue
      q = Queue.new(start_node)


      visited = []
      num_of_nodes.times do |i|
          visted.push false
      end

      visited[start_node] = true

      prev = []
      num_of_nodes.times do |i|
          prev.push nil
      end

      while q.size > 0
          node = q.dequeue
          neighbors = g.get(node)

          i = 0
          while i < neighbors.size
              next_node = neighbors[i]
              if not visited[next_node]
                  q.enqueue next_node
                  visited[next_node] = true
                  prev[next_node] = node
              end
          end
      end

      prev
  end

  # reconstruct path ging backwards from end node
  def reconstruct_path(start_node, end_node, prev)
      path = []
      while end_node
  end

  class Queue
      attr_accessor :storage

      def initalize(start_node)
          self.storage.push start_node
      end

      def enqueue node
          self.storage.push node
      end

      def dequeue
        self.storage.shift
      end
  end

end
