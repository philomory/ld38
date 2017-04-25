class InputManager
  include Gosu
  
  DEFAULT_BINDINGS_1 = {
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
    KbN => :toggle_sfx
  }
  
  MODIFIERS = [KbLeftShift, KbRightShift]
  
  MODIFIED_BINDINGS_1 = {
    :north => :throw_north,
    :south => :throw_south,
    :west => :throw_west,
    :east => :throw_east
  }
  
  DEFAULT_BINDINGS_2 = {
    KbW => :north,
    KbS => :south,
    KbA => :west,
    KbD => :east,
    KbUp => :throw_north,
    KbDown => :throw_south,
    KbLeft => :throw_west,
    KbRight => :throw_east,
    KbEscape => :quit
  }
  
  attr_reader :queued_input
  def initialize(game)
    @game = game
    @queued_input = []
    @input_bindings = DEFAULT_BINDINGS_1.dup
    @modified_bindings = MODIFIED_BINDINGS_1.dup
  end
  
  def button_down(id)
    action = @input_bindings[id]
    action = (@modified_bindings[action] || action) if modifier_down?
    @game.handle_input(action)
  end
  
  def queue_input(action)
    @queued_input.push(action) if @queued_input.empty?
  end
  
  def modifier_down?
    MODIFIERS.any? {|key| $game.button_down?(key) }
  end
  
end