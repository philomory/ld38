class GameState
  class PlayerDiedState < GameState

    def initialize(*args)
      super
      @locked = true
      font_path = MediaManager.font_path('large')
      message1 = "Undo: U"
      message2 = "Restart: R"
      @message1 = Gosu::Image.from_text(message1, 44, font: font_path, retro: true)
      @message2 = Gosu::Image.from_text(message2, 44, font: font_path, retro: true)
    end

    def handle_input(action)
      case action
      when :undo then @locked = false; UndoManager.undo_turn!
      when :restart then @locked = false; $game.restart_level
      end
    end
    
    def draw
      Gosu.draw_rect(0,0,$game.width,$game.height,0xEE000000,11)
      MediaManager.font("large").draw_rel("...darkness...?",$game.width/2,100,14,0.5,0.5)
      @message1.draw_rot(50, center_y,14,0,0.0,0.5,1,1,0xFFFFFFFF)
      @message2.draw_rot($game.width-50, center_y,14,0,1.0,0.5,1,1,0xFFFFFFFF)
    end
    
    def next_state
      self
    end
    
    def locked?
      @locked
    end
    
    def draw_world?
      false
    end
    
    def fullscreen?
      true
    end
    

  end
end