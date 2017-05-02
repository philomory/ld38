class GameState
  class CheckWorldState < GameState
    def on_enter
      game.world.props.each(&:check_state)
      if game.game_state == self && game.animation_manager.nothing_to_do?
        game.game_state = WaitingForPlayer.new(game)
      end
    end
  end
end