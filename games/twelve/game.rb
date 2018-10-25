require_relative 'square'

class Game
    def initialize(window)
        @window = window
        @squares = []
        color_list = []
        [:red, :green, :blue].each do |color|
            12.times do
                color_list << color
            end
        end
        color_list.shuffle!
        (0..5).each do |row|
            (0..5).each do |column|
                index = row * 6 + column
                @squares << Square.new(@window, column, row, color_list[index])
            end
        end
        @font = Gosu::Font.new(36)
    end

    def draw
        for square in @squares
            square.draw
        end
    end

    def handle_mouse_down(x, y)
        row = (y.to_i - 20) / 100
        column = (x.to_i - 20) / 100
        @start_square = get_square(column, row)
    end

    def get_square(column, row)
        if column < 0 || column > 5 || row < 0 || row > 5
            return nil
        else
            return @squares[row * 6 + column]
        end
    end

    def handle_mouse_up(x, y)
        row = (y.to_i - 20) / 100
        column = (x.to_i - 20) / 100
        @end_square = get_square(column, row)
        if @start_square and @end_square
            move(@start_square, @end_square)
        end
        @start_square = nil
    end

    def square_between_in_row(square1, square2)
        the_squares = []
        if square1.column < square2.column
            column_start, column_end = square1.column, square2.column  
        else
            column_start, column_end = square2.column, square1.column
        end
        (column_start .. column_end) do |column|
            the_squares << get_square(column, square1.row)
        end
        return the_squares
    end

    def square_between_in_column(square1, square2)
        the_squares = []
        if square1.row < square2.row
            column_start, row_end = square1.row, square2.row  
        else
            row_start, row_end = square2.row, square1.row
        end
        (column_start .. column_end) do |row|
            the_squares << get_square(square1.column, row)
        end
        return the_squares
    end

    def move(square1, square2)
        return if square1.number == 0
        if square1.row == square2.row
            squares = square_between_in_row(square1, square2)
        elsif square1.column == square2.column
            squares = square_between_in_column(square1, square2)
        else
            return
        end
        squares.reject! {|square| square.number == 0}
        return if squares.count != 2
        return if squares[0].color != squares[1].color
        #valid move if nothing is triggered
    end
end