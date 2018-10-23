class Explosion
    attr_reader :finished

    def initialize(window, death_x, death_y)
        @window = window
        @x = death_x
        @y = death_y
        @radius = 30
        @images = Gosu::Images.load_tiles('sprites/explosions.png', 60, 60)
        @image_index = 0
        @finished = false
    end

    def draw
        if @image_index < @images.count
            @images[@image_index].draw(@x - @radius, @y - @radius, 2)
            @image_index += 1
        else
            @finished = true
        end
    end
end