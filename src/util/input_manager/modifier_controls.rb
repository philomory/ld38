class InputManager
  class ModifierControls < ControlType

    InputManager.register(:modifier, self)
    
    DEFAULT_BINDINGS = {
      KbUp => :north,
      KbDown => :south,
      KbLeft => :west,
      KbRight => :east,
      KbW => :north,
      KbS => :south,
      KbA => :west,
      KbD => :east,
      KbEscape => :quit,
      KbR => :restart,
      KbM => :toggle_music,
      KbN => :toggle_sfx,
    }
  
    MODIFIERS = [KbLeftShift, KbRightShift]
  
    MODIFIED_BINDINGS = {
      :north => :throw_north,
      :south => :throw_south,
      :west => :throw_west,
      :east => :throw_east
    }
    
    BIND_LIST = {
      north: "Move Up",
      sourth: "Move Down",
      west: "Move Left",
      east: "Move Right",
      modifier: "Hold for Throw",
      quit: "Quit Game",
      restart: "Restart Level",
      toggle_music: "Music On/Off",
      toggle_sfx: "SFX On/Off"     
    }

    attr_reader :queued_input
    def setup_bindings
      @input_bindings = DEFAULT_BINDINGS.dup
      @modified_bindings = MODIFIED_BINDINGS.dup
      @modifiers = MODIFIERS.dup
    end
    
    def bindings=(bindings)
      @modifiers = [bindings.delete(:modifier)]
      @input_bindings = bindings.invert
    end
    
    def bind_list
      self.class::BIND_LIST
    end
  
    def action_for_button_id(id)
      action = @input_bindings[id]
      action = (@modified_bindings[action] || action) if modifier_down?
      action
    end
  
    def modifier_down?
      @modifiers.any? {|key| $game.button_down?(key) }
    end
    
  end
end