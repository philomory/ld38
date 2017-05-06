class GameState
  class ConfigMenu < Menu
    def setup_menu
      @title = "Configure Controls"
      add_option("Choose Control Style") { transition_to(GameState::ControlStyleMenu.new) }
      add_option("View/Customize Controls") { transition_to(GameState::ReviewInputBindings.new) }
      add_option("Back") { transition_to(GameState::MainMenu.new) }
    end
  end
end