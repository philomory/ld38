require 'forwardable'

class World
  extend Forwardable
  
  WIDTH = 12
  HEIGHT = 8
  
  def_delegators :@grid, :[]
    
  attr_reader :grid
  def initialize(level="level1")
    level_data = load_level(level)
    @grid = Grid.new(WIDTH,HEIGHT) {|cell| cell.terrain = level_data[cell.x,cell.y] }
  end
  
  def load_level(level)
    TileMap.new(level)
  end
  
  def method_missing(name,*args,&blk)
    if @grid.respond_to?(name)
      warn "Called #{name} directly on World, should delegate to Grid"
      @grid.send(name,*args,&blk)
    else
      super
    end
  end
  
end