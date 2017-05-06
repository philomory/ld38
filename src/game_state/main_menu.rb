class GameState
  class MainMenu < Menu
    def setup_menu
      @title = "Strangeness"
      @background_image = MediaManager.image("main_menu")
      add_option("Start Game") { @game.start_game }
      add_option("Options") { transition_to(GameState::ConfigMenu.new) }
      add_option("Quit Game") { exit }
    end
  end
end