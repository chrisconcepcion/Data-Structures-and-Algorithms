# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
class BSTIterator

=begin
    :type root: TreeNode
=end
    attr_accessor :current_node, :previewed_next, :root, :next_node
    def initialize(root)
        @current_node = TreeNode.new(-1, nil, nil)
        @next_node = inorder_successor(root, @current_node)
        @previewed_next_val = @next_node.val
        @root = root
    end


=begin
    :rtype: Integer
=end
    def next()
        if @previewed_next_val
            @current_node = @next_node
            @next_node = nil
            @previewed_next_val = false
            if @current_node
                return @current_node.val
            else
                return nil
            end
        else
            @current_node = inorder_successor(@root, @current_node)
            if @current_node
                return @current_node.val
            end
            @next_node = nil
            @previewed_next_val = false
        end

    end


=begin
    :rtype: Boolean
=end
    def has_next()
        if @previewed_next_val
            return true
        else
            if @current_node
                @next_node = inorder_successor(@root, @current_node)
                if @next_node
                     @previewed_next_val = @next_node.val
                end

                if @previewed_next_val
                    return true
                else
                    return false
                end

            else
                return false
            end


        end

    end


end

def inorder_successor(root, p)

    current_successor = nil
    current_successor_left = nil
    current_successor_left = nil
    if p
        if root != p
       if root.val > p.val
           current_successor = root
       end
    end

    if root.left
        current_successor_left = search_left_subtree(root.left, root, p, current_successor)
    end

    if root.right
        current_successor_right = search_right_subtree(root.right, root, p, current_successor)
    end

    if current_successor_left && current_successor_right
        if current_successor_right.val > current_successor_left.val
            return current_successor_left
        else
            return current_successor_right
        end
    elsif current_successor_left
        return current_successor_left
    elsif current_successor_right
        return current_successor_right
    end

    end


    return current_successor
end

def search_left_subtree(node, parent, seeking_node, current_successor = nil)
    if node
        original_node = node
        original_parent = parent

        if (node.val > seeking_node.val)
            if !current_successor
                current_successor = node
            elsif current_successor
                if node.val < current_successor.val
                    current_successor = node
                end
            end
        end

        while node.left
            parent = node
            node = node.left

            if (node.val > seeking_node.val)
                if !current_successor
                    current_successor = node
                elsif current_successor
                    if node.val < current_successor.val
                        current_successor = node
                    end
                end
            end

            if node.right
                right_node = search_right_subtree node.right, parent, seeking_node, current_successor
                if (right_node && (right_node.val > seeking_node.val))
                    if !current_successor
                        current_successor = right_node
                    elsif current_successor
                        if right_node.val < current_successor.val
                            current_successor = right_node
                        end
                    end
                end
            end
        end

        node = original_node
        parent = original_parent
        if node.right
            node = search_right_subtree node.right, parent, seeking_node, current_successor
            if (node && (node.val > seeking_node.val))
                if !current_successor
                    current_successor = node
                elsif current_successor
                    if node.val < current_successor.val
                        current_successor = node
                    end
                end
            end
        end
    end

    current_successor
end

def search_right_subtree(node, parent, seeking_node, current_successor = nil)
    if node
        original_node = node
        original_parent = parent

        if (node.val > seeking_node.val)
            if !current_successor
                current_successor = node
            elsif current_successor
                if node.val < current_successor.val
                    current_successor = node
                end
            end
        end

        while node.right
            parent = node
            node = node.right

            if (node.val > seeking_node.val)
                if !current_successor
                    current_successor = node
                elsif current_successor
                    if node.val < current_successor.val
                        current_successor = node
                    end
                end
            end

            if node.left
                node_left = search_left_subtree node.left, parent, seeking_node, current_successor
                if (node_left && (node_left.val > seeking_node.val))
                    if !current_successor
                        current_successor = node_left
                    elsif current_successor
                        if node_left.val < current_successor.val
                            current_successor = node_left
                        end
                    end
                end
            end
        end

        node = original_node
        parent = original_parent
        if node.left
            node = search_left_subtree node.left, parent, seeking_node, current_successor
            if (node && (node.val > seeking_node.val))
                if !current_successor
                    current_successor = node.val
                elsif current_successor
                    if node.val < current_successor.val
                        current_successor = node
                    end
                end
            end
        end

    end

    current_successor
end

# Your BSTIterator object will be instantiated and called as such:
# obj = BSTIterator.new(root)
# param_1 = obj.next()
# param_2 = obj.has_next()


def gather_node_values(root, node_vals = [])

    node_vals << root.val


    if root.left
        node_vals = current_successor_left = collect_left_subtree(root.left, node_vals)
    end

    if root.right
        node_vals = current_successor_right = collect_right_subtree(root.right, node_vals)
    end

    return node_vals
end

def collect_left_subtree(node, node_vals)
    if node
      node = original_node
      node_vals << node.val


        while node.left
            node = node.left

            node_vals << node.val

            if node.right
                node_vals = collect_right_subtree node.right, node_vals
            end
        end

        node = original_node
        if node.right
            node_vals = collect_right_subtree node.right, node_vals
        end
    end

    node_vals
end

def collect_right_subtree(node, node_vals)
    if node
        original_node = node
        node_vals << node.val


        while node.right
            node = node.right

            node_vals << node.val

            if node.left
                node_vals = collect_left_subtree node.left, node_vals

            end
        end

        node = original_node
        if node.left
            node_vals = collect_left_subtree node.left, node_vals
        end
    end

    node_vals
end
