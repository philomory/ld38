class GameState
  class ConfigMenu < Menu
    def setup_menu
      @title = "Configure Controls"
      add_option("Choose Control Style") { transition_to(GameState::ControlStyleMenu.new) }
      add_option("Customize Input") { transition_to(GameState::CustomizeInputMenu.new) }
      add_option("Back") { transition_to(GameState::MainMenu.new) }
    end
  end
end