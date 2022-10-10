# Trie is a data structure. Trie is also known as a prefix tree.
# Trie data strcture helps organize a word list and quickly find words that
# start with a specific prefix. Trie is a special form of a Nary Tree.

# Sources:
# https://www.youtube.com/watch?v=YG6iX28hmd0
# https://leetcode.com/explore/learn/card/trie/150/introduction-to-trie/1045/

# Sample Problem, constructing a Trie class.
# https://leetcode.com/problems/implement-trie-prefix-tree/submissions/
# Runtime: 191 ms, faster than 98.55% of Ruby online submissions for Implement Trie (Prefix Tree).

class Trie
    attr_accessor :root, :end
    def initialize
        # Our hash used to store prefix letter as a key for each entry.
        @root = {}
        # This is a suffix to indicate the end of a word.
        @end = "#"
    end

    # Inserts a string into our trie.
    def insert(string)
        node = @root
        index = 0
        string_size = string.size
        while index < string_size
            char = string[index]
            if not node[char]
                node[char] = {}
            end
            node = node[char]

            index = index + 1
        end
        node[@end] = true
    end

    def search(string)
        node = @root
        index = 0
        string_size = string.size
        while index < string_size
            char = string[index]
            if not node[char]
                 return false
            end
            node = node[char]

            index = index + 1
        end
        node[@end] == true
    end

    def starts_with(prefix)
        node = @root
        index = 0
        prefix_size = prefix.size
        while index < prefix_size
            char = prefix[index]
            if not node[char]
                return false
            end
            node = node[char]

            index = index + 1
        end
        true
    end
end

trie = Trie.new
trie.search "apple"
trie.insert "apple"
trie.search "apple"
trie.search "app"
trie.starts_with "app"
trie.insert "app"
trie.search "app"
