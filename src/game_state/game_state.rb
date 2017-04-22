class GameState
  attr_reader :game
  def initialize(game)
    @game = game
  end
  
  def handle_input(action)
  end
  
  def on_enter
  end
  
  def on_exit
  end
  
  def update
  end
  
  def draw
  end
end