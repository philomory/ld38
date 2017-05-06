class GameState
  class ConfigMenu < Menu
    def setup_menu
      @title = "Options"
      add_option("Music: #{MediaManager.music? ? "On" : "Off"}") { MediaManager.toggle_music }
      add_option("SFX: #{MediaManager.sfx? ? "On" : "Off"}") { MediaManager.toggle_sfx }
      add_option("Choose Control Style") { transition_to(GameState::ControlStyleMenu.new) }
      add_option("View/Customize Controls") { transition_to(GameState::ReviewInputBindings.new) }
      add_option("Back") { transition_to(parent_menu) }
    end
    
    def parent_menu
      $game.paused? ? GameState::PauseMenu.new : GameState::MainMenu.new
    end
  end
end