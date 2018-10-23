class Player
    def initialize(window)
        @x = 200
        @y = 200
        @angle = 0
        @image = Gosu::Image.new('sprites/ship.png')
        @x_velocity = 0
        @y_velocity = 0
    end

    def draw
        @image.draw_rot(@x, @y, 1, @angle)
    end

    def turn_right
        @angle += 5
    end

    def turn_left
        @angle -= 5
    end

    def move
        @x += @x_velocity
        @y += @y_velocity
        @x_velocity *= 0.9
        @y_velocity *= 0.9
    end

    def accelerate
        @x_velocity += Gosu.offset_x(@angle, 2)
        @y_velocity += Gosu.offset_y(@angle, 2)
    end
end