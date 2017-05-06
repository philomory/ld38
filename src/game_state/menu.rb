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
    
    def menu_start_pos
      center_y + 25 - (@options.count * 25)
    end
    
    def draw
      #bg_color = (0xEE * (1.0 - fade_portion)).floor * 0x01000000
      @background_image.draw(0,0,11)
      draw_text(@title,100,1.5)
      @options.each_with_index do |option,index|
        scale = (index == @position) ? 1.5 : 1
        ypos = menu_start_pos + (75 * index)
        text = option[:text].respond_to?(:call) ? option[:text].call : option[:text]
        draw_text(text,ypos,scale)
      end
    end
    
    def handle_input(action)
      case action
      when :south, :throw_south then @position += 1
      when :north, :throw_north then @position -= 1
      when :accept then trigger_selected
      when :pause then on_menu_button
      end
      @position %= @options.length
    end
    
    def on_menu_button
      back
    end
    
    def back
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