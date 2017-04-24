class InputManager
  include Gosu
  
  DEFAULT_BINDINGS_1 = {
    KbUp => :north,
    KbDown => :south,
    KbLeft => :west,
    KbRight => :east,
    KbEscape => :quit
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
    @input_bindings = DEFAULT_BINDINGS_2.dup
  end
  
  def button_down(id)
    action = @input_bindings[id]
    @game.handle_input(action)
  end
  
  def queue_input(action)
    @queued_input.push(action) if @queued_input.empty?
  end
  
end