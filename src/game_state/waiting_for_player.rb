class GameState
  class WaitingForPlayer < GameState
    
    def on_enter
      input = @game.input_manager.queued_input.shift
      handle_input(input) if input
    end
        
    def handle_input(action)
      case action
      when :north, :south, :east, :west
        game.player.move(action) { game.game_state = EnemyAction.new(game) }
      when /throw_(?<dir>\w+)/
        game.player.throw_weapon($~[:dir].to_sym) { game.game_state = EnemyAction.new(game) }
      when :wait
        if game.waiting_allowed?
          game.game_state = EnemyAction.new(game)
        else
          MediaManager.play_sfx("buzzer")
        end
      end
    end
  end
  
  def next_state
    EnemyAction.new(game)
  end
  
  def animation_duration
    100
  end
end
