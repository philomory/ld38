class GameState
  class Menu < GameState
    
    def initialize(*args)
      super
      @position = 0
      @options = []
      @background_image = MediaManager.image("credits")
      @title = ""
      setup_menu
    end
    
    
    def fullscreen?
      true
    end
    
    def add_option(text,&blk)
      @options << {text: text, action: blk }
    end
    
    def draw
      #bg_color = (0xEE * (1.0 - fade_portion)).floor * 0x01000000
      @background_image.draw(0,0,11)
      draw_text(@title,100)
      @options.each_with_index do |option,index|
        scale = (index == @position) ? 1.5 : 1
        ypos = 300 + (75 * index)
        draw_text(option[:text],ypos,scale)
      end
    end
    
    def handle_input(action)
      case action
      when :south then @position += 1
      when :north then @position -= 1
      when :accept then trigger_selected
      end
      @position %= @options.length
    end
      
    def transition_to(state)
      @game.game_state = GameState::FadeTransition.new(self,state)
    end
      
    def trigger_selected
      @options[@position][:action].call
    end
    
    
    def draw_text(msg,ypos,scale = 1)
      MediaManager.font('large').draw_rel(msg,center_x, ypos, 14,0.5,0.5,scale,scale)
    end
    
    def draw_world?
      false
    end
    
  end
end