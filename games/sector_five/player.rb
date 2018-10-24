class Player
    ROTATION_SPEED = 5
    ACCELERATION = 2
    FRICTION = 0.9
    attr_reader :x, :y, :angle, :radius

    def initialize(window)
        @x = 200
        @y = 200
        @angle = 0
        @image = Gosu::Image.new('sprites/ship.png')
        @x_velocity = 0
        @y_velocity = 0
        @radius = 20
        @window = window
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
        if @x > @window.width - @radius
            @x_velocity = 0
            @x = @window.width - @radius
        end
        if @x < @radius
            @x_velocity = 0
            @x = @radius
        end
        if @y > @window.height - @radius 
            @y_velocity = 0
            @y = @window.height - @radius
        end
    end

    def accelerate
        @x_velocity += Gosu.offset_x(@angle, ACCELERATION)
        @y_velocity += Gosu.offset_y(@angle, ACCELERATION)
    end
end