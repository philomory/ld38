require 'gosu'

class Game < Gosu::Window
  def self.play!
    new.show
  end
    
  attr_reader :game_state, :world, :player, :enemies
  def initialize
    super 800, 600, false
    
    $game = self

    @input_manager = InputManager.new(self)
    self.caption = "Your Ruby/Gosu game goes here"
    
    @world = World.new
    
    @player = Player.new
    @player.position=(@world[0,0])
    
    @enemies = [[1,5],[2,3],[4,4]].map {|x,y| [Pacer,Wanderer].sample.new.tap {|e| e.position = @world[x,y] } }
    
    self.game_state = GameState::WaitingForPlayer.new(self)
  end

  def draw
    Gosu.scale(SCALE_FACTOR,SCALE_FACTOR,0,0) do
      @world.grid.each(&:draw)
    end
  end

  def button_down(id)
    @input_manager.button_down(id)
  end
  
  def handle_input(action)
    exit if action == :quit
    @game_state.handle_input(action)
  end
  
  def game_state=(state)
    @game_state.on_exit if @game_state
    @game_state = state
    @game_state.on_enter if @game_state
  end
  
  def update
    @game_state.update
  end
  
  def player_died
    restart_level
  end
  
  def restart_level
    #TODO: Implement levels
  end
  
  def needs_cursor?
    false
  end
end
