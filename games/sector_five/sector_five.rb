require 'gosu'
require_relative 'player'
require_relative 'enemy'

class SectorFive < Gosu::Window
    WIDTH = 800
    HEIGHT = 600
    ENEMY_FREQUENCY = 0.05

    def initialize
        super(WIDTH, HEIGHT)
        self.caption = 'Sector Five'
        @player = Player.new(self)
        @enemies = []
    end

    def draw
        @player.draw
        for enemy in @enemies
            enemy.draw
        end
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
    end
end

window = SectorFive.new
window.show