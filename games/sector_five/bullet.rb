class Bullet
    SPEED = 5

    def initialize(window, player_x, player_y, player_angle)
        @window = window
        @x = player_x
        @y = player_y
        @direction = player_angle
        @image = Gosu::Image.new('sprites/bullet.png')
        @radius = 3
    end

    def draw
        @image.draw_rot(@x - @radius, @y - @radius, 1, @direction)
    end

    def move
        @x += Gosu.offset_x(@direction, SPEED)
        @y += Gosu.offset_y(@direction, SPEED)
    end
end