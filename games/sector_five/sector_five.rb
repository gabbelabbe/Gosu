require 'gosu'
require_relative 'player'
require_relative 'enemy'
<<<<<<< HEAD
=======
require_relative 'bullet'
require_relative 'explosion'
>>>>>>> fcd34d6cdef2cddf96afe449ea48a1c1523554aa

class SectorFive < Gosu::Window
    WIDTH = 800
    HEIGHT = 600
    ENEMY_FREQUENCY = 0.05

    def initialize
        super(WIDTH, HEIGHT)
        self.caption = 'Sector Five'
        @player = Player.new(self)
<<<<<<< HEAD
        @enemy = Enemy.new(self)
=======
        @enemies = []
        @bullets = []
        @explosions = []
>>>>>>> fcd34d6cdef2cddf96afe449ea48a1c1523554aa
    end

    def draw
        @player.draw
<<<<<<< HEAD
        @p
=======
        for enemy in @enemies
            enemy.draw
        end
        for bullet in @bullets
            bullet.draw
        end
        for explosion in @explosions
            explosion.draw
        end
>>>>>>> fcd34d6cdef2cddf96afe449ea48a1c1523554aa
    end

    def update
        @player.turn_left if button_down?(Gosu::KbLeft)
        @player.turn_right if button_down?(Gosu::KbRight)
        @player.accelerate if button_down?(Gosu::KbUp)
        @player.move
        if rand < ENEMY_FREQUENCY
            @enemies << Enemy.new(self)
        end
        for enemy in @enemies
            enemy.move
        end
        for bullet in @bullets
            bullet.move
        end
        for enemy in @enemies
            for bullet in @bullets
                distance = Gosu.distance(enemy.x, enemy.y, bullet.x, bullet.y)
                if distance < enemy.radius + bullet.radius
                    @enemies.delete enemy
                    @bullets.delete bullet
                    @explosions << Explosion.new(self, enemy.x, enemy.y)
                end
            end 
        end
        for explosion in @explosions
            @explosions.delete explosion if explosion.finished
        end
        for enemy in @enemies
            if enemy.y > HEIGHT + enemy.radius
                @enemies.delete enemy
            end
        end
        for bullet in @bullets
            @bullets.delete bullet unless bullet.onscreen?
        end
    end

    def button_down(id)
        if id == Gosu::KbSpace
            @bullets << Bullet.new(self, @player.x, @player.y, @player.angle)
        end
    end
end

window = SectorFive.new
window.show