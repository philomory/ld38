class GameState
  class ControlStyleMenu < Menu
    def setup_menu
      @title = "Choose Control Style"
      add_option("Hold Modifier to Throw") { InputManager.input_style = :modifier; back }
      add_option("Dedicated Throw Controls") { InputManager.input_style = :separate; back }
      add_option("Back") { back }
    end
    
    
    def back
      transition_to(GameState::ConfigMenu.new )
    end
    
    def draw
      super
      #TODO: add explanations for the two control methods
    end
      
    
  end
end