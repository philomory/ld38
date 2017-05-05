class InputManager
  class MenuControls < ControlType

    InputManager.register(:menu, self)
    
    DEFAULT_BINDINGS = {
      KbUp => :north,
      KbDown => :south,
      KbLeft => :west,
      KbRight => :east,
      KbEscape => :quit,
      KbSpace => :accept,
      KbEnter => :accept,
      KbReturn => :accept
    }
    
    def setup_bindings
    end
  
    def action_for_button_id(id)
      DEFAULT_BINDINGS[id]
    end
    
  end
end