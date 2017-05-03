require 'forwardable'

class World
  extend Forwardable
  
  WIDTH = 12
  HEIGHT = 8
  
  def_delegators :@grid, :[]
    
  attr_reader :grid, :player, :enemies, :props
  def initialize(level)
    
    Trigger.reset!
    
    level_data = TileMap.new(level)
    @grid = Grid.new(WIDTH,HEIGHT) { |cell| cell.terrain = level_data[cell.x,cell.y] }
    
    @props = level_data.props.map do |tmo|
      prop = Prop.new(tmo.type,tmo.properties)
      prop.position = @grid[tmo.x,tmo.y]
      prop
    end
    
    @enemies = level_data.enemies.map do |tmo|
      enemy = Enemy.new(tmo.type,tmo.properties)
      enemy.position = @grid[tmo.x,tmo.y]
      enemy
    end
    
    @triggers = level_data.triggers.map do |tmo|
      Trigger.new(@grid[tmo.x,tmo.y], (tmo.properties["group"] || :default).to_sym)
    end
    
    tmo = level_data.player
    @player = Player.new(health:1, weapon_count: tmo.properties['rocks'].to_i || 3)
    @player.position = @grid[tmo.x, tmo.y]
     
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