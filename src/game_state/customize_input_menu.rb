class GameState
  class CustomizeInputMenu < GameState
    
    def draw_world?
      false
    end
  
    def fullscreen?
      true
    end
  
    def needs_raw_input?
      true
    end

    def initialize
      super
      @needed_actions = InputManager.current_manager.bind_list
      @bindings = {}
    end
    
    def current_input_description
      @needed_actions.values.first
    end
    
    def draw
      MediaManager.font('large').draw_rel(current_input_description,center_x, center_y, 14,0.5,0.5)
    end
    
    def button_down(id)
      if @bindings.values.include?(id)
        MediaManager.play_sfx("buzzer")
      else
        action = @needed_actions.keys.first
        @needed_actions.delete(action)
        @bindings[action] = id
        finish if @needed_actions.empty?
      end
    end
    
    def finish
      InputManager.current_manager.bindings = @bindings
      $game.game_state = GameState::FadeTransition.new(self,GameState::MainMenu.new)    
    end
      
    
  end
end