require 'forwardable'

class World
  extend Forwardable
  
  WIDTH = 8
  HEIGHT = 6
  
  def_delegators :@grid, :[]
    
  attr_reader :grid
  def initialize(level=:dummy)
    level_data = load_level(level)
    @grid = Grid.new(WIDTH,HEIGHT) {|cell| cell.terrain = level_data[cell.y][cell.x] }
  end
  
  def load_level(level)
    Array.new(HEIGHT) { Array.new(WIDTH,Terrain::Grass) }
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