class GameState
  class LevelSelect < Menu
    def setup_menu
      @title = "Choose a Level"
      add_slider("Level",0,Settings[:max_level],Settings[:max_level]) { }
      add_option("Back") { transition_to(GameState::MainMenu.new) }
    end
  
    def handle_input(action)
      if action == :accept && @position == 0
        @game.start_game(selected_option.current_value)
      else
        super
      end
    end
    
    def back

    end
  end
end