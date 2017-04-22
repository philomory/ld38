class GameState
  class EnemyAction < GameState
    
    def on_enter
      if game.enemies.any?
        setup_turn
      else
        game.game_state = WaitingForPlayer.new(game)
      end
    end
    
    def setup_turn
      @last_move = 0
      game.enemies.each(&:ready_to_move!)
    end
    
    DELTA = 250
    
    def update
      if Gosu.milliseconds > @last_move + DELTA
        @last_move = Gosu.milliseconds
        if game.enemies.any?(&:ready_to_move?)
          move_next_enemy
        else
          game.game_state = GameState::WaitingForPlayer.new(game)
        end
      end
    end
    
    def move_next_enemy
      game.enemies.select(&:ready_to_move?).first.make_your_move!
    end
    
  end
end