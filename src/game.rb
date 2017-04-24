require 'gosu'

class Game < Gosu::Window
  def self.play!
    new.show
  end
    
  attr_reader :game_state, :world, :player, :enemies, :input_manager, :level
  def initialize
    super 800, 600, false
    
    $game = self

    @input_manager = InputManager.new(self)
    @animation_manager = AnimationManager.new(self)
    self.caption = "Your Ruby/Gosu game goes here" #TODO: Change caption
    
    @ui = UI.new(self)

    @level = 0
    setup_level
  end

  def draw
    @ui.draw
    
    Gosu.translate(0,UI_HEIGHT) do
      Gosu.scale(SCALE_FACTOR,SCALE_FACTOR,0,0) do
        @world.grid.each(&:draw)
        @game_state.draw unless @game_state.fullscreen?
      end
    end
    @game_state.draw if @game_state.fullscreen?
  end

  def button_down(id)
    binding.pry if id == Gosu::KB_BACKTICK
    @input_manager.button_down(id)
  end
  
  def animation_duration
    @game_state.animation_duration
  end
  
  def handle_input(action)
    exit if action == :quit
    @game_state.handle_input(action)
  end
  
  def game_state=(state)
    return if @game_state&.locked?
    @game_state.on_exit if @game_state
    @game_state = state
    @game_state.on_enter if @game_state
  end
  
  def update
    @animation_manager.play_if_pending!
    @game_state.update
  end
  
  def player_died
    restart_level
  end
  
  def enemy_died(who)
    enemies.delete(who)
  end
  
  def schedule_animation(anim,&callback)
    @animation_manager.schedule_animation(anim,&callback)
  end
  
  def restart_level
    setup_level
  end
  
  def next_level
    @level += 1
    setup_level
  end
  
  def setup_level
    @world = World.new(@level)
    #self.game_state = GameState::WaitingForPlayer.new(self)
    self.game_state = GameState::LevelSplashScreen.new(self) { self.game_state = GameState::WaitingForPlayer.new(self) }
  end
    
  def player
    @world.player
  end
  
  def enemies
    @world.enemies
  end
  
  def needs_cursor?
    false
  end
end
