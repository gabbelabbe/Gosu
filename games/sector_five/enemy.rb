class Enemy
<<<<<<< HEAD
    def initialize(window)
        @x = rand(window + 1)
        @y = 0
        @image = 
    end
=======
    SPEED = 4
    attr_reader :x, :y, :radius

    def initialize(window)
        @radius = 20
        @x = rand(window.width - 2 * @radius) + @radius
        @y = 0
        @image = Gosu::Image.new('sprites/enemy.png')
    end

    def move
        @y += SPEED
    end

    def draw
        @image.draw(@x - @radius, @y - @radius, 1)
    end

>>>>>>> fcd34d6cdef2cddf96afe449ea48a1c1523554aa
end