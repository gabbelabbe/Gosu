class Player
    ROTATION_SPEED = 5
    ACCELERATION = 2
    FRICTION = 0.9

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
        @angle += ROTATION_SPEED
    end

    def turn_left
        @angle -= ROTATION_SPEED
    end

    def move
        @x += @x_velocity
        @y += @y_velocity
        @x_velocity *= FRICTION
        @y_velocity *= FRICTION
    end

    def accelerate
        @x_velocity += Gosu.offset_x(@angle, ACCELERATION)
        @y_velocity += Gosu.offset_y(@angle, ACCELERATION)
    end
end