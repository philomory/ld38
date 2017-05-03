require 'gosu'

class Game < Gosu::Window
  def self.play!
    new.show
  end
    
  attr_reader :game_state, :world, :player, :enemies, :input_manager, :level, :animation_manager
  def initialize
    super 896, 690, false
    
    $game = self

    @input_manager = InputManager.controls(:modifier).new(self)
    @animation_manager = AnimationManager.new(self)
    self.caption = "Strangeness"
    
    @ui = UI.new(self)
    
    @levels = YAML.load_file(File.join(DATA_ROOT,'levels.yml'))

    @level = 0
    setup_level
    MediaManager.play_music
  end

  def draw
    @ui.draw
    
    Gosu.translate(0,UI_HEIGHT) do
      Gosu.scale(SCALE_FACTOR,SCALE_FACTOR,0,0) do
        MediaManager.image("background").draw(0,0,0)
        Gosu.translate(TILE_WIDTH,TILE_HEIGHT) do
          @world.grid.each(&:draw)
          @game_state.draw unless @game_state.fullscreen?
        end
      end
      MediaManager.image("background0").draw(0,0,0) if @level == 0
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
    case action
    when :quit then exit
    when :restart then restart_level
    when :toggle_music then MediaManager.toggle_music
    when :toggle_sfx then MediaManager.toggle_sfx
    else @game_state.handle_input(action)
    end
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
  
  def waiting_allowed?
    false # @world.waiting_allowed?
  end
  
  def next_level
    MediaManager.play_sfx('portal')
    @level += 1
    @level < @levels.count ? setup_level : to_be_continued
  end
  
  def setup_level
    @world = World.new(@levels[@level])
    #self.game_state = GameState::WaitingForPlayer.new(self)
    self.game_state = GameState::LevelSplashScreen.new(self) { self.game_state = GameState::WaitingForPlayer.new(self) }
  end
  
  def to_be_continued
    self.game_state = GameState::YouWinScreen.new(self)
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
