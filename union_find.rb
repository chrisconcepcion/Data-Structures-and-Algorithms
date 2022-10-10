# Quick Find variant(Fast find, slow union).
class UnionFind
    attr_accessor :root

    # O(N) space complexity since we are storing the array of size N.
    def initialize(size)
        @root = (0..size - 1).to_a
    end

    # Returns the parent for a vertices.
    # O(1) time complexity since we are returning an element in an array with
    # an index.
    def find(x)
        @root[x]
    end

    # Created a union for 2 vertices.
    # O(N) time complexity since we are searching through an array. We will
    # generally always have a time complexity of O(N) or greater.
    def union(x,y)
        root_x = self.find(x)
        root_y = self.find(y)
        if root_x != root_y
            index = 0
            root_size = @root.size
            while index < root_size
                if root[index] == root_y
                    @root[index] = root_x
                    break
                end
                index = index + 1
            end
        end
    end

    # Returns true if two vertices are connected.
    # O(1) time complexity since it only requires two find calls.
    def connected(x,y)
        return self.find(x) == self.find(y)
    end
end


# Test Case
uf = UnionFind.new(10)
# 1-2-5-6-7 3-8-9 4
uf.union(1, 2)
uf.union(2, 5)
uf.union(5, 6)
uf.union(6, 7)
uf.union(3, 8)
uf.union(8, 9)
(uf.connected(1, 5))  # true
(uf.connected(5, 7))  # true
(uf.connected(4, 9))  # false
# 1-2-5-6-7 3-8-9-4
uf.union(9, 4)
(uf.connected(4, 9))  # true

# Quick Union variant(Fast union, slow find).
class UnionFind
    attr_accessor :root

    # O(N) space complexity since we are storing the array of size N.
    # O(N) time complexity as we are creating an array of size N.
    def initialize(size)
        @root = (0..size - 1).to_a
    end

    # Returns the parent for a vertices.
    # We enumerate over the root array until we get to a root node.
    # O(N) time complexity since we are searching an array but generally faster.
    def find(x)
        # keep enumerating until we run into a root node.
        while x != @root[x]
            x = @root[x]
        end

        return x
    end

    # Created a union for 2 vertices.
    # O(N) time complexity since we are only using two finds, doing a comparision
    # and a reassignment if they are not in a union already.
    # In some cases, we may have a time complexity faster than O(N).
    # Worse case is O(n^2).
    def union(x,y)
        root_x = self.find(x)
        root_y = self.find(y)
        if root_x != root_y
            @root[root_y] = root_x
        end
    end

    # Returns true if two vertices are connected.
    # O(N) time complexity since it only requires two find calls.
    def connected(x,y)
        return self.find(x) == self.find(y)
    end
end

# Test Case
uf = UnionFind.new(10)
# 1-2-5-6-7 3-8-9 4
uf.union(1, 2)
uf.union(2, 5)
uf.union(5, 6)
uf.union(6, 7)
uf.union(3, 8)
uf.union(8, 9)
(uf.connected(1, 5))  # true
(uf.connected(5, 7))  # true
(uf.connected(4, 9))  # false
# 1-2-5-6-7 3-8-9-4
uf.union(9, 4)
(uf.connected(4, 9))  # true

### Why is Quick Union More Efficient than Quick Find?
# This is because with Quick-find, the union operation will always have a
# complexity greater than or equal to N. This is not the case for Quick-union,
# the find operation can perform computations less than N.


### Now we move onto the most efficient variation of UnionFind, Union by Rank

# UnionFind by Rank class
# ALSO NOTE: Time complexity has changed per method though only union method has
# changed. This is due to the tree structure added by using rankings.
class UnionFind
    attr_accessor :root, :rank

    # O(N) space complexity since we are storing the array of size N.
    # O(N) time complexity as we are creating an array of size N.
    def initialize(size)
        # Create an element for each size of the tree with it's index as the
        # value.
        @root = (0..size - 1).to_a
        # Each element has a rank of 1.
        @rank = [1] * size
    end

    # Returns the parent for a vertices.
    # We enumerate over the root array until we get to a root node.
    # O(log N) time complexity.
    def find(x)
        # keep enumerating until we run into a root node.
        while x != @root[x]
            x = @root[x]
        end

        return x
    end

    # O(log N) time complexity.
    def union(x, y)
        root_x = self.find(x)
        root_y = self.find(y)
        if root_x != root_y
            # When root_x has the largest rank, make root_y root node root_x.
            if @rank[root_x] > @rank[root_y]
                @root[root_y] = root_x
            # When root_y has the largest rank, make root_x root node root_x.
            elsif @rank[root_x] < @rank[root_y]
                @root[root_x] = root_y
            # When root_x and root_y have the same rank,
            # select root_x as the root node and increase root_x ranking.
            else
                @root[root_y] = root_x
                @rank[root_x] += 1
            end
        end
    end

    # Returns true if two vertices are connected.
    # # O(log N) time complexity since it only requires two find calls.
    def connected(x,y)
        return self.find(x) == self.find(y)
    end
end




# Test Case
uf = UnionFind.new(10)
# 1-2-5-6-7 3-8-9 4
uf.union(1, 2)
uf.union(2, 5)
uf.union(5, 6)
uf.union(6, 7)
uf.union(3, 8)
uf.union(8, 9)
(uf.connected(1, 5))  # true
(uf.connected(5, 7))  # true
(uf.connected(4, 9))  # false
# 1-2-5-6-7 3-8-9-4
uf.union(9, 4)
(uf.connected(4, 9))  # true


### Alright here we go again, another optimization...
# Path Compression Optimization.
# The optimization is for the find method, as we enumerate over the root array
# until we get to a root node, for each non-root we call find on the result
# setting its root node to match to match x.

class UnionFind
    attr_accessor :root, :rank

    # O(N) space complexity since we are storing the array of size N.
    # O(N) time complexity as we are creating an array of size N.
    def initialize(size)
        # Create an element for each size of the tree with it's index as the
        # value.
        @root = (0..size - 1).to_a
        # Each element has a rank of 1.
        @rank = [1] * size
    end

    # Returns the parent for a vertices.
    # We enumerate over the root array until we get to a root node.
    # O(α(N)) which is about O(1) on average time complexity.
    # Enumerate over the root array until we get to a root node,
    # for each non-root we call find on the result
    # setting its root node to match the root node of x.
    def find(x)
        # keep enumerating until we run into a root node.
        if x == @root[x]
            return x
        end
        @root[x] = self.find(@root[x])
        return @root[x]
    end

    # O(α(N)) which is about O(1) on average time complexity.
    def union(x, y)
        root_x = self.find(x)
        root_y = self.find(y)
        if root_x != root_y
            # When root_x has the largest rank, make root_y root node root_x.
            if @rank[root_x] > @rank[root_y]
                @root[root_y] = root_x
            # When root_y has the largest rank, make root_x root node root_x.
            elsif @rank[root_x] < @rank[root_y]
                @root[root_x] = root_y
            # When root_x and root_y have the same rank,
            # select root_x as the root node and increase root_x ranking.
            else
                @root[root_y] = root_x
                @rank[root_x] += 1
            end
        end
    end

    # Returns true if two vertices are connected.
    # O(α(N)) which is about O(1) on average time complexity.
    def connected(x,y)
        return self.find(x) == self.find(y)
    end
end




# Test Case
uf = UnionFind.new(10)
# 1-2-5-6-7 3-8-9 4
uf.union(1, 2)
uf.union(2, 5)
uf.union(5, 6)
uf.union(6, 7)
uf.union(3, 8)
uf.union(8, 9)
(uf.connected(1, 5))  # true
(uf.connected(5, 7))  # true
(uf.connected(4, 9))  # false
# 1-2-5-6-7 3-8-9-4
uf.union(9, 4)
(uf.connected(4, 9))  # true


### Example Problems.
#547. Number of Provinces : https://leetcode.com/problems/number-of-provinces/

# @param {Integer[][]} is_connected
# @return {Integer}
def find_circle_num(is_connected)
    # Notes:
    # We returning how many individual provinces are available.
    # A province is a group of directly or indirectly connected cities and no other cities outside of the group.
    # isConnected[i][j] = 1 if the ith city and the jth city are directly connected,
    # isConnected[i][j] = 0 otherwise.

    # 1. Create a UnionFind object.
    # 2. Union all cities found in is_connected array.
    # 3. Collect the amount of individual provinces.

    cities_count = is_connected.size
    ## 1. Create a UnionFind object.
    uf = UnionFind.new(cities_count)


    ## 2. Union all cities found in is_connected array.
    index = 0

    # While loop to enumerate is_connected array.
    while index < cities_count
        city =  is_connected[index]
        index_connections = 0
        city_size = city.size
        # For each city array create a union if there is a connection
        # between the cities(isConnected[i][j] = 1 means connected).
        while index_connections < city_size
            if city[index_connections] == 1
                uf.union(index, index_connections)
            end

            index_connections = index_connections + 1
        end
       index = index + 1
    end

    ## 3. Collect the amount of individual provinces.
    # We determine the amount of individual provinces by when an index
    # equates to uf.root[index].
    index = 0
    individual_provinces = 0
    root_size = uf.root.size
    while index < root_size
        if index == uf.root[index]
           individual_provinces = individual_provinces + 1
        end
        index = index + 1
    end
    individual_provinces
end


class UnionFind
    attr_accessor :root, :rank

    # O(N) space complexity since we are storing the array of size N.
    # O(N) time complexity as we are creating an array of size N.
    def initialize(size)
        # Create an element for each size of the tree with it's index as the
        # value.
        @root = (0..size - 1).to_a
        # Each element has a rank of 1.
        @rank = [1] * size
    end

    # Returns the parent for a vertices.
    # We enumerate over the root array until we get to a root node.
    # Enumerate over the root array until we get to a root node,
    # for each non-root we call find on the result
    # setting its root node to match the root node of x.
    # O(α(N)) which is about O(1) on average time complexity.
    def find(x)
        # keep enumerating until we run into a root node.
        if x == @root[x]
            return x
        end
        @root[x] = self.find(@root[x])
        return @root[x]
    end

    # O(α(N)) which is about O(1) on average time complexity.
    def union(x, y)
        root_x = self.find(x)
        root_y = self.find(y)
        if root_x != root_y
            # When root_x has the largest rank, make root_y root node root_x.
            if @rank[root_x] > @rank[root_y]
                @root[root_y] = root_x
            # When root_y has the largest rank, make root_x root node root_x.
            elsif @rank[root_x] < @rank[root_y]
                @root[root_x] = root_y
            # When root_x and root_y have the same rank,
            # select root_x as the root node and increase root_x ranking.
            else
                @root[root_y] = root_x
                @rank[root_x] += 1
            end
        end
    end

    # Returns true if two vertices are connected.
    # O(α(N)) which is about O(1) on average time complexity.
    def connected(x,y)
        return self.find(x) == self.find(y)
    end
end
