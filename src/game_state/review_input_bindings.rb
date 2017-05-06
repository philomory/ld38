class GameState
  class ReviewInputBindings < Menu
    
    def setup_menu
      @title = "Current Bindings"
      add_option("Back") { transition_to(GameState::ConfigMenu.new) }
      add_option("Customize Bindings") { transition_to(GameState::CustomizeInputMenu.new) }
      add_option("Restore Defaults") { InputManager.restore_default_bindings; MediaManager.play_sfx("portal"); }
    end
    
    def menu_start_pos
      475
    end
    
    def draw
      super
      InputManager.current_manager.current_bindings.each_with_index {|(desc, keys),index| draw_binding(desc,keys,index) }
    end
    
    def draw_binding(desc,keys,index)
      font = MediaManager.font('small')
      ypos = 150 + 25 * index
      key_str = names_for(keys)
      font.draw_rel("#{desc}:",center_x-80, ypos, 14,1.0,0.5)
      font.draw_rel(key_str,center_x-70,ypos, 14, 0.0, 0.5)
    end
    
    def names_for(keys)
      keys.map(&method(:name_of_key)).join(", ")
    end
    
    def name_of_key(key)
      char = Gosu.button_id_to_char(key)
      return char.upcase if char.length > 0
      sym = (Gosu.constants - [:MAJOR_VERSION, :MINOR_VERSION, :POINT_VERSION, :VERSION, :LICENSES]).find {|const| Gosu.const_get(const) == key }
      return sym.to_s if sym
      key
    end
    
  end
end