class InputManager
  class SeparateControls < ControlType

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
  end
end