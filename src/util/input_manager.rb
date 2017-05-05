class InputManager
  
  METHODS = {}
  
  def self.register(key,klass)
    METHODS[key] = klass
  end
  
  def self.controls(type=:modifier)
    METHODS[type]
  end
  
  def self.input_style=(key)
    $game.input_manager = controls(key).new($game)
  end
  
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