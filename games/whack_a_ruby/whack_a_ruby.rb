require 'gosu'

class WhackARuby < Gosu::Window
    def initialize
        super 800,600
        self.caption = "Whack the Ruby!"
        @image = Gosu::Image.new('img/ruby.png')
        @x = 200
        @y = 200
        @width = 50
        @height = 43
        @x_velocity = 5
        @y_velocity = 5
    end

    def draw
        @image.draw(@x - @width/2, @y - @height/2, 1)
    end

    def update
        @x += @x_velocity
        @y += @y_velocity
    end
end

window = WhackARuby.new
window.show