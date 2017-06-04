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
      KbEscape => :pause,
      KbR => :restart,
      KbZ => :undo,
      KbU => :undo
    }.freeze
  
    MODIFIERS = [KbLeftShift, KbRightShift].freeze
  
    MODIFIED_BINDINGS = {
      :north => :throw_north,
      :south => :throw_south,
      :west => :throw_west,
      :east => :throw_east
    }.freeze
    
    BIND_LIST = {
      north: "Move Up",
      south: "Move Down",
      west: "Move Left",
      east: "Move Right",
      modifier: "Hold for Throw",
      pause: "Pause Game",
      restart: "Restart Level",
      undo: "Undo Move"
    }.freeze

    attr_reader :queued_input
    def setup_bindings
      restore_default_bindings
    end
    
    def restore_default_bindings
      @input_bindings = DEFAULT_BINDINGS.dup
      @modified_bindings = MODIFIED_BINDINGS.dup
      @modifiers = MODIFIERS.dup
    end
    
    def bindings=(bindings)
      @modifiers = [bindings.delete(:modifier)]
      @input_bindings = bindings.invert
    end
    
    def bind_list
      self.class::BIND_LIST.dup
    end
    
    def current_bindings
      action_keys = Hash.new {|h,k| h[k] = []}
      @input_bindings.each_pair {|key,action| action_keys[action] << key }
      action_keys[:modifier] = @modifiers
      bind_list.map {|action, desc| [desc, action_keys[action]] }
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