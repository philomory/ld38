class Lock < Prop
  
  register_type("Lock",self)
  
  def initialize(type,properties)
    @type = type
    @pushable = false
    @blocks_enemy = @blocks_bullet = true
  end
  
  def blocks_player?
    !$game.player.has_key?
  end
  
  def position=(new_cell)
    new_cell.terrain = new_cell.terrain.dup
    new_cell.terrain.passable = true
    super
  end
  
  def on_enter(unit)
    $game.player.lose_key
    @cell.terrain = Terrain::Grass
    @cell.prop = nil
  end
  

  
end