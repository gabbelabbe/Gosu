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
            draw_start()
        when :game
            draw_game()
        when :end
            draw_end()
        end
    end

    def draw_start
        @background_image.draw(0,0,0)
    end

    def draw_game
        @player.draw
        for enemy in @enemies
            enemy.draw
        end
        for bullet in @bullets
            bullet.draw
        end
        for explosion in @explosions
            explosion.draw
        end
    end

    def update
        case @scene
        when :game
            update_game()
        when :end
            update_end()
        end
    end

    def button_down(id)
        case @scene
        when :start
            button_down_start(id)
        when :game
            button_down_game(id)
        when :end
            button_down_end(id)
        end
    end

    def button_down_start
        initialize_game()
    end

    def initialize_game
        @player = Player.new(self)
        @enemies = []
        @bullets = []
        @explosions = []
        @scene = :game
    end
end

window = SectorFive.new
window.show