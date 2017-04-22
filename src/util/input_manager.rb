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
  
  def initialize(game)
    @game = game
    @input_bindings = DEFAULT_BINDINGS_2.dup
  end
  
  def button_down(id)
    action = @input_bindings[id]
    @game.handle_input(action)
  end
  
end