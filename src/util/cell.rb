class Cell
  attr_reader :x, :y
  attr_accessor :terrain, :occupant
  
  def initialize(x,y,grid)
    @x, @y, @grid = x, y, grid
    @worked = false
  end
  
  def draw
    @terrain.draw(xpos,ypos)
    @occupant.draw(xpos,ypos) if occupant && !occupant.animating?
  end
  
  def xpos
    x*TILE_WIDTH
  end
  
  def ypos
    y*TILE_HEIGHT
  end
  
  def passable?
    terrain.passable? && occupant.nil?
  end
  
  def blocked?
    !passable?
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
  end
  
end