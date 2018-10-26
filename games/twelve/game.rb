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
        if game_over?
            c = Gosu::Color.argb(0x33000000)
            @window.draw_quad(0, 0, c, 640, 0, c, 640, 640, c, 0, 640, c, 4)
            @font.draw_text("Game Over!", 230, 240, 5)
            @font.draw_text("CTRL-R to Play Again", 225, 320, 5, 0.6, 0.6)
            return
        end
        return unless @start_square
        @start_square.highlight(:start)
        return unless @current_square && @current_square != @start_square
        if move_is_legal?(@start_square, @current_square)
            @current_square.highlight(:legal)
        else
            @current_square.highlight(:illegal)
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
        (column_start .. column_end).each do |column|
            the_squares << get_square(column, square1.row)
        end
        return the_squares
    end

    def square_between_in_column(square1, square2)
        the_squares = []
        if square1.row < square2.row
            row_start, row_end = square1.row, square2.row  
        else
            row_start, row_end = square2.row, square1.row
        end
        (row_start .. row_end).each do |row|
            the_squares << get_square(square1.column, row)
        end
        return the_squares
    end

    def move(square1, square2)
        valid = move_is_legal?(square1, square2)
        return unless valid
        #valid move if nothing is triggered

        squares = valid[1]
        color = squares[0].color
        number = squares[0].number + squares[1].number
        squares[0].clear
        squares[1].clear
        square2.set(color, number)
    end

    def handle_mouse_move(x, y)
        row = (y.to_i - 20) / 100
        column = (x.to_i - 20) / 100
        @current_square = get_square(column, row)
    end

    def move_is_legal?(square1, square2)
        return false if square1.number == 0
        if square1.row == square2.row
            squares = square_between_in_row(square1, square2)
        elsif square1.column == square2.column
            squares = square_between_in_column(square1, square2)
        else
            return false
        end
        squares.reject! {|square| square.number == 0}
        return false if squares.count != 2
        return false if squares[0].color != squares[1].color
        return true, squares
    end

    def legal_move_for?(start_square)
        return false if start_square.number == 0
        for end_square in @squares
            if move_is_legal?(start_square, end_square)
                return true
            end
        end
        return false
    end

    def game_over?
        for square in @squares
            return false if legal_move_for?(square)
        end
        return true
    end
end