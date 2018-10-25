require 'gosu'
require_relative 'player'
require_relative 'enemy'
require_relative 'bullet'
require_relative 'explosion'
require_relative 'credits'

class SectorFive < Gosu::Window
    WIDTH = 800
    HEIGHT = 600
    ENEMY_FREQUENCY = 0.05
    MAX_ENEMIES = 100

    def initialize
        super WIDTH, HEIGHT
        self.caption = "Sector Five"
        @background_image = Gosu::Image.new('sprites/start_screen.png')
        @scene = :start
        @start_music = Gosu::Song.new('sounds/Lost Frontier.ogg')
        @start_music.play(true)
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

    def button_down_start(id)
        initialize_game()
    end

    def initialize_game
        @player = Player.new(self)
        @enemies = []
        @bullets = []
        @explosions = []
        @scene = :game
        @enemies_appeared = 0
        @enemies_destroyed = 0
        @game_music = Gosu::Song.new('sounds/Cephalopod.ogg')
        @game_music.play(true)
    end

    def update_game
        @player.turn_left if button_down?(Gosu::KbLeft)
        @player.turn_right if button_down?(Gosu::KbRight)
        @player.accelerate if button_down?(Gosu::KbUp)
        @player.move
        if rand < ENEMY_FREQUENCY
            @enemies << Enemy.new(self)
            @enemies_appeared += 1
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
                    @enemies_destroyed += 1
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
        initialize_end(:count_reached) if @enemies_appeared > MAX_ENEMIES
        for enemy in @enemies
            distance = Gosu.distance(enemy.x, enemy.y, @player.x, @player.y)
            initialize_end(:hit_by_enemy) if distance < @player.radius + enemy.radius
        end
        initialize_end(:off_top) if @player.y < -@player.radius
    end

    def button_down_game(id)
        if id == Gosu::KbSpace
            @bullets << Bullet.new(self, @player.x, @player.y, @player.angle)
        end
    end

    def initialize_end(fate)
        case fate
        when :count_reached
            @message = "You made it! You destroyed #{@enemies_destroyed} ships"
            @message2 = "and #{MAX_ENEMIES - @enemies_destroyed} reached the base."
        when :hit_by_enemy
            @message = "You were struck by an enemy ship."
            @message2 = "Before your ship was destroyed, "
            @message2 += "you took out #{@enemies_destroyed} enemy ships."
        when :off_top
            @message = "You got too close to the enemy mother ship."
            @message2 = "Before your ship was destroyed, "
            @message2 += "you took out #{@enemies_destroyed} enemy ships."
        end
        @bottom_message = "Press P to play again, or Q to quit."
        @message_font = Gosu::Font.new(28)
        @credits = []
        y = 700
        File.open('credits.txt').each do |line|
            @credits << Credit.new(self, line.chomp, 100, y)
            y += 30  
        end
        @scene = :end
        @end_music = Gosu::Song.new('sounds/FromHere.ogg')
        @end_music.play(true)
    end

    def draw_end
        clip_to(50, 140, 700, 360) do
            @credits.each do |credit|
                credit.draw
            end
        end
        draw_line(0, 140, Gosu::Color::RED, WIDTH, 140, Gosu::Color::RED)
        @message_font.draw_text(@message, 40, 40, 1, 1, 1, Gosu::Color::FUCHSIA)
        @message_font.draw_text(@message2, 40, 75, 1, 1, 1, Gosu::Color::FUCHSIA)
        draw_line(0, 500, Gosu::Color::RED, WIDTH, 500, Gosu::Color::RED)
        @message_font.draw_text(@bottom_message, 180, 540, 1, 1, 1, Gosu::Color::AQUA)
    end

    def update_end
        for credit in @credits
            credit.move
        end
        if @credits.last.y < 150
            for credit in @credits
                credit.reset
            end 
        end
    end

    def button_down_end(id)
        if id == Gosu::KbP
            initialize_game
        elsif id == Gosu::KbQ
            close
        end
    end
end

window = SectorFive.new
window.show