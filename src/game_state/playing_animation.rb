class GameState
  class PlayingAnimation < GameState
    
    def initialize(game,animation,&callback)
      @game, @animation, @callback = game, animation, callback
    end
    
    def on_enter
      @animation.play!(&@callback)
    end
        
    def draw
      @animation.draw
    end
    
    def update
      @animation.update
    end
    
  end
end