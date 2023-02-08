# This solution fails. 

# @param {Character[][]} board
# @param {String} word
# @return {Boolean}
def exist(board, word)

    # go through board until we need first letter


    board_size = board.size
    x_max = board[0].size - 1
    y_max = board_size - 1



    y_index = 0

    finder = Bfsfind.new(board, word, x_max, y_max, board_size)
    finder.find word
    return finder.found
    return finder.debug
    #return finder.visited.to_s
end

class Bfsfind
    attr_accessor :found, :debug, :visited
    def initialize(board, word, x_max, y_max, board_size)
        @board= board
        @word = word
        @x_max = x_max
        @y_max = y_max
        @visited = {}
        @found = false
        @board_size = board_size
        @debug = []
    end

    def find word
        found = false
        y_index = 0
        x_row_length = @x_max + 1
        while y_index < @board_size
            row = @board[y_index]

            x_index = 0

            while x_index < x_row_length

                if @board[y_index][x_index] == word[0]

                    new_word = word[1..-1]
                    if new_word.size == 0

                        @found = true
                        found = true
                        break
                    end
                    @visited = {}

                    found = find_remaining_letters new_word, y_index, x_index
                    if found
                        @found = true
                        break
                    end
                end

                if found
                    break
                end

                x_index = x_index + 1
            end

            if found
                    break
                end

            y_index = y_index + 1
        end

        found

    end

    def find_remaining_letters word, y, x


        # check for neighbors of found letter to find next letter
        # do not allow returning back to original neighbors
        found = false
        @visited[[y, x]] = true
        letter = word[0]
        word = word[1..-1]



        # check all 4 directions from y and x to find the next letter
        found_neighbors = neighboard_has_letter y, x, letter



        if found_neighbors.size > 0


            next_letter = word[0]




            if next_letter == nil
                return true
            else
                old_visted = @visited.dup
                found_neighbors.each do |found_neighbor|


                    @visited = old_visted.dup
                    found = find_remaining_letters word, found_neighbor[0], found_neighbor[1]
                    if found
                        break
                    end
                end
                return found

            end

        else
            return false
        end
    end

    def neighboard_has_letter y, x, letter
        found_neighbors = []
        # check all 4 directions from y and x to find the next letter
        if y < @y_max
            new_y = y+1
            new_x = x
            new_text = [new_y, new_x]
            if @board[new_y][new_x] == letter && !@visited[new_text]
                found_neighbors << [new_y, new_x]
            end
        end

        if x < @x_max
            new_y = y
            new_x = x + 1
            new_text = [new_y, new_x]
            if @board[new_y][new_x] == letter && !@visited[new_text]
                found_neighbors << [new_y, new_x]
            end
        end

        if y > 0
            new_y = y - 1
            new_x = x
            new_text = [new_y, new_x]
            if @board[new_y][new_x] == letter && !@visited[new_text]
                found_neighbors << [new_y, new_x]
            end
        end


        if x > 0
            new_y = y
            new_x = x - 1
            new_text = [new_y, new_x]
            if @board[new_y][new_x] == letter && !@visited[new_text]
                found_neighbors << [new_y, new_x]
            end
        end


        return found_neighbors
    end

end
