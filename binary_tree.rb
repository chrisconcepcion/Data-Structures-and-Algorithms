module BinaryTree
  # Binary Search Tree is a special form of a bninary tree.
  # Rules:
  # 1. Subtrees on the left must less than or equal to any values in the right subtree.
  # 2. Subtrees on the right must have greater than or equal to any values in the left subtree.
  # 3. All subtrees(left and right) must also be binary search trees.

  # Valid BST must follow all 3 rules.
  # Example of Valid BST
  #       5
  #     /   \
  #   3      6

  # Example of Invalid BST
  #       7
  #     /  \
  #    3    6
  #        /  \
  #       4    8
  #
  # The reason this is invalid is 7 is larger than 6.

  # Inorder Successor:
  # An inorder successor to a node is the node with the smallest key greater than node.val .
  #     2
  #   /  \
  #  1    3
  #
  # In this example, when node = 1, inorder successor is 2.
  #
  # NOTE: The answer is always the node with the next value higher than node, it
  # does not matter if there is a direct relationship or not.

  # Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val = 0, left = nil, right = nil)
#         @val = val
#         @left = left
#         @right = right
#     end
# end
# @param {TreeNode} root
# @return {Boolean}
def is_valid_bst(root)

    # transverse root array going through each element ensuring the value meets the requirments of
    # 1. Subtrees on the left must less than or equal to any values in the right subtree.
    # 2. Subtrees on the right must have greater than or equal to any values in the left subtree.
    # 3. All subtrees(left and right) must also be binary search trees.

    valid = true

     left_root = root.left
    # search left
    if left_root
        #return "#{left_root.val} < #{root.val}"
       if left_root.val < root.val
           val = validate_left_subtree left_root, root, root, nil
           if val != true
               return val
           end
           if val == false
               return false
           end


       else
           return false
       end
    end

    right_root = root.right
    if right_root
       if right_root.val > root.val
          val = validate_right_subtree right_root, root, nil, root

           if val == false
               return false
           end
       else
           return false
       end
    end

    true
end

def validate_left_subtree node, parent, stronger_tree_root_node = nil, weaker_tree_root_node = nil
    valid = true

    if node
        if not (node.val < parent.val)
            return false

        end

        if stronger_tree_root_node && (not ( node.val < stronger_tree_root_node.val))
           return false
        end

        if weaker_tree_root_node && (not (weaker_tree_root_node.val < node.val))
                return false
        end

        original_node = node
        original_stronger_tree_root_node = stronger_tree_root_node



        while node.left
            parent = node
            stronger_tree_root_node = parent
            node = node.left

            if not (node.val < parent.val)
                return false
            end

            # stronger_tree_root_node value should ALWAYS exceed node.left val
            if stronger_tree_root_node && (not (node.val < stronger_tree_root_node.val))
                return false
            end

            if weaker_tree_root_node && (not (weaker_tree_root_node.val < node.val))
                return false
            end

            if node.right
                val = validate_right_subtree node.right, node, stronger_tree_root_node, node
                if val == false
                    return false
                end
            end


        end

        node = original_node
        stronger_tree_root_node = original_stronger_tree_root_node

        if node.right
            weaker_tree_root_node = node
            val = validate_right_subtree node.right, node, stronger_tree_root_node, weaker_tree_root_node
            if val == false
                return false
            end
        end
    end

    valid
end

def validate_right_subtree node, parent, stronger_tree_root_node = nil, weaker_tree_root_node = nil
    valid = true
    if node
        if not (parent.val < node.val)
            return false
        end

        # stronger_tree_root_node value should ALWAYS exceed node.left val
        if stronger_tree_root_node && (not (node.val < stronger_tree_root_node.val))
            return false
        end

        if weaker_tree_root_node && (not (weaker_tree_root_node.val < node.val))
            return false
        end

        if node.left
            val = validate_left_subtree node.left, node, node, weaker_tree_root_node
            if val == false
                return false

            end
        end


        while node.right

            parent = node
            weaker_tree_root_node = parent
            node = node.right

            if not (parent.val < node.val)
                return false
            end

            # stronger_tree_root_node value should ALWAYS exceed node.left val
            if stronger_tree_root_node && (not (node.val < stronger_tree_root_node.val))
                return false
            end

            if weaker_tree_root_node && (not (weaker_tree_root_node.val < node.val))
                return false
            end

            if node.left
                val = validate_left_subtree node.left, node, node, weaker_tree_root_node
                if val == false
                    return false
                end
            end
        end
    end

    valid
end

# Definition for a binary tree node.
# class TreeNode
#     attr_accessor :val, :left, :right
#     def initialize(val)
#         @val = val
#         @left, @right = nil, nil
#     end
# end

# @param {TreeNode} root
# @param {TreeNode} p
# @return {TreeNode}
def inorder_successor(root, p)

    current_successor = nil
    current_successor_left = nil
    current_successor_left = nil
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
