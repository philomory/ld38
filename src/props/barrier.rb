class Barrier < Prop
  
  register_type("Barrier",self)
  
  def initialize(type,properties)
    @type = type
    @group = (properties["group"] || :default).to_sym
    @pushable = false
  end
  
  def blocks_player?
    !Trigger.activated?(@group)
  end
  
  def blocks_enemy?
    !Trigger.activated?(@group)
  end
  
  alias_method :blocks_enemy?, :blocks_player?
  alias_method :blocks_bullet?, :blocks_player?
  
  def imagename
    if blocks_player?
      Gosu.milliseconds % 1000 >= 500 ? "barrier_1" : "barrier_2" 
    else
      "empty"
    end
  end
  
  def check_state
    @cell.occupant.fry if @cell.occupant && blocks_player?
  end
  
end