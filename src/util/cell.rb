class Cell
  attr_reader :x, :y
  attr_accessor :terrain, :prop, :trigger
  attr_reader :occupant
  
  def initialize(x,y,grid)
    @x, @y, @grid = x, y, grid
    @worked = false
  end
  
  def occupant=(unit)
    occupant_left(@occupant) if @occupant 
    @occupant = unit
    @prop.on_enter(unit) if @prop && unit
  end
  
  def occupant_left(occupant)
    terrain_collapse! if terrain.collapsing? && occupant.causes_collapse?
  end
  
  def terrain_collapse!
    @terrain = Terrain::Empty
  end
  
  def draw
    terrain.draw(xpos,ypos)
    trigger.draw(xpos,ypos) if trigger
    occupant.draw(xpos,ypos) if occupant && !occupant.animating?
    prop.draw(xpos,ypos) if prop && !prop.animating?
  end
  
  def xpos
    x*TILE_WIDTH
  end
  
  def ypos
    y*TILE_HEIGHT
  end
  
  def passable?(passer)
    terrain.passable?(passer) && occupant.nil? && (prop.nil? || prop.passable?(passer))
  end
  
  def weapon_hit(weapon,dir,remaining_distance)
    if occupant
      occupant.attacked(weapon)
    elsif prop && !prop.passable?(weapon)
      prop.weapon_hit(weapon,dir,remaining_distance)
    end
  end

  def blocked?(passer)
    !passable?(passer)
  end
  
  def neighbor_in_direction(dir)
    case dir
    when :north then north
    when :south then south
    when :east then east
    when :west then west
    else raise "Invalid Direction: #{dir.inspect}"
    end
  end
  
  def north; @grid[x,y-1] end
  def south; @grid[x,y+1] end
  def east;  @grid[x+1,y] end
  def west;  @grid[x-1,y] end
  
  def valence(radius)
    @grid.valence(x,y,radius)
  end
  
  def around(radius)
    @grid.around(x,y,radius)
  end
  
  class OutOfBounds < Cell
    def terrain
      Terrain::OutOfBounds
    end
    def room_for_prop?(*args)
      false
    end
  end
  
end