# 39 out of 49 test passing
# https://leetcode.com/problems/number-of-islands/
# @param {Character[][]} grid
# @return {Integer}
def num_islands(grid)
    island_finder = IslandFinder.new(grid)
    island_finder.calculate_number_of_islands
    return island_finder.number_of_islands
    #island_finder.coordinate_map.to_s
end


class IslandFinder
    attr_accessor :coordinate_map, :number_of_islands, :grid

    def initialize(grid)
        @coordinate_map = {}
        @number_of_islands = 0
        @grid = grid
        @x_coordinate_max = @grid[0].size - 1
        @y_coordinate_max = @grid.size - 1
    end

    def calculate_number_of_islands

        y_coordinate = 0
        grid_size = @grid.size
        while y_coordinate < grid_size

            x_coordinate = 0
            grid_x_size = @grid[0].size
            while x_coordinate < grid_x_size
                coordinate = [y_coordinate ,x_coordinate]
                current_coordinate_val = @grid[y_coordinate][x_coordinate]
                # check if this coordinate has been explored

                if @coordinate_map[coordinate]
                else
                    # check if current_coordinate_val returns an island
                    # or
                    # water.

                    # set coordinate map for this coordinate to "water"
                    if current_coordinate_val == "0"
                        @coordinate_map[coordinate] = "water"
                    else
                        # Update num of islands as we found a new island
                        @number_of_islands = @number_of_islands + 1
                        # set coordinate map for coordinate to be the island count
                        @coordinate_map[coordinate] = @number_of_islands
                        # find all other coordinates attached to the island
                        map_remaining_coordinates_of_island coordinate
                    end
                end

                x_coordinate = x_coordinate + 1
            end

            y_coordinate = y_coordinate + 1
        end
    end

    def map_remaining_coordinates_of_island coordinate
        # explore all directions of the coordinate
        to_be_tested = [coordinate]

        while to_be_tested.size > 0
            current_coordinate = to_be_tested.shift
            current_coordinate_val = @grid[current_coordinate[0]][current_coordinate[1]]
            if current_coordinate_val == "0"
                        @coordinate_map[current_coordinate] = "water"
            else

                # set coordinate map for coordinate to be the island count
                @coordinate_map[current_coordinate] = @coordinate_map[coordinate]



                y_coordinate = current_coordinate[0]
                x_coordinate = current_coordinate[1]
                # north
                if y_coordinate > 0 && !@coordinate_map[[y_coordinate - 1, x_coordinate]]
                    to_be_tested << [y_coordinate - 1, x_coordinate]
                end

                # west
                if x_coordinate > 0 && !@coordinate_map[[y_coordinate, x_coordinate - 1]]
                    to_be_tested << [y_coordinate, x_coordinate - 1]
                end

                # south
                if y_coordinate < @y_coordinate_max && !@coordinate_map[[y_coordinate + 1, x_coordinate]]
                    to_be_tested << [y_coordinate + 1, x_coordinate]
                end


                # east
                if x_coordinate < @x_coordinate_max && !@coordinate_map[[y_coordinate, x_coordinate + 1]]
                    to_be_tested << [y_coordinate, x_coordinate + 1]
                end
            end



        end
    end

end
