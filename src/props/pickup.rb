class Pickup < Prop
  
  def initialize(type,properties)
    @type = type
    @pushable = @blocks_player = @blocks_enemy = @bocks_bullet = false
  end

  def on_enter(unit)
    return unless unit.player?
    pickup!
    @cell.prop = nil
  end
  
  def passable?(passer)
    passer.is_a?(Enemy::Stone) ? false : super
  end
  
  def pickup!
    raise NotImplementedError, "Subclasses must implemenet :pickup!"
  end
    
  

  
end