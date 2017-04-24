class Key < Prop
  
  register_type("Key",self)
  
  def initialize(type,properties)
    @type = type
    @pushable = @blocks_player = @blocks_enemy = @bocks_bullet = false
  end
  
  def on_enter(unit)
    $game.player.gain_key
    @cell.prop = nil
  end
  

  
end