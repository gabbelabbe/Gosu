require 'gosu'

class Square
    attr_reader :row, :column, :number, :color

    def initialize(window, column, row, color)
        @@colors ||= {
            red: Gosu::Color.argb(0xaaff0000),
            green: Gosu::Color.argb(0xaa00ff00),
            blue: Gosu::Color.argb(0xaa0000ff)
        }
        @@font ||= Gosu::Font.new(72)
        @@window ||= window
        @row = row
        @column = column
        @color = color
        @number = 1
    end
end