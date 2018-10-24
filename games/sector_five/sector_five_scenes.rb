require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'

class SectorFive < Gosu::Window
    WIDTH = 800
    HEIGHT = 600
    ENEMY_FREQUENCY = 0.05

    def initialize
        super WIDTH, HEIGHT
        self.caption = "Sector Five"
        @background_image = Gosu::Image.new('sprites/start_screen.png')
        @scene = :start    
    end

    def draw
        case @scene
        when :start
            draw_start
        when :game
            draw_game
        when :end
            draw_end
        end
    end
end

window = SectorFive.new
window.show