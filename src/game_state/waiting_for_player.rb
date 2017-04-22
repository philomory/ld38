class GameState
  class WaitingForPlayer < GameState
    def handle_input(action)
      case action
      when :north, :south, :east, :west
        game.player.move(action)
        game.game_state = EnemyAction.new(game)
      when /throw_(?<dir>\w+)/
        game.player.throw_weapon($~[:dir].to_sym)
        game.game_state = EnemyAction.new(game)
      end
    end
  end
end
