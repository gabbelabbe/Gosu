require 'gosu'

class GolWindow < Gosu::Window

    WIDTH = 800
    ROWS = COLUMNS = 60
    RES = WIDTH/ROWS

    def initialize
        super WIDTH, WIDTH
        self.caption = 'Game of Life Ruby'
        @grid = create_grid
    end

    def create_grid
        grid = []
        COLUMNS.times do |i|
            column = []
            ROWS.times do |j|
                column << rand(2)
            end
            grid << column
        end
        return grid
    end

    def count_neighbours(x,y)
        sum = 0
        i = -1
        col = 0
        rows = 0
        while i < 2
            j = -1
            while j < 2
                col = (x + i + COLUMNS) % COLUMNS
                row = (y + j + ROWS) % ROWS 
                sum += @grid[col][row]
                j += 1
            end
            i += 1
        end
        return sum - @grid[x][y]
    end

    def next_grid
        temp = create_grid
        live = 0
        COLUMNS.times do |i|
            ROWS.times do |j|
                state = @grid[i][j]
                live = count_neighbours(i,j)
                if state == 0 && live == 3
                    temp[i][j] = 1
                elsif state == 1 && live < 2
                    temp[i][j] = 0
                elsif state == 1 && live > 3
                    temp[i][j] = 0
                else
                    temp[i][j] = @grid[i][j]
                end
            end
        end
        @grid = temp
    end

    def draw
        COLUMNS.times do |i|
            ROWS.times do |j|
                color = Gosu::Color.rgb(@grid[i][j] * 255, @grid[i][j] * 255, @grid[i][j] * 255)
                Gosu.draw_rect(i*RES,j*RES,RES,RES,color)
            end
        end
    end

    def update
        next_grid()
        sleep 0.025
    end
end

g = GolWindow.new
g.show