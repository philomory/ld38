class Terrain
  def self.register(name,object)
    @registry ||= {}
    @registry[name] = object
  end
    
  
  attr_reader :name, :color
  def initialize(name:, passable: true, color: 0xFFFFFFFF,&blk)
    @name, @passable, @color = name, passable, color
    instance_exec(&blk) if block_given?
    Terrain.register(name,self)
  end
  def imagename
    name
  end
  def image
    ImageManager.image(imagename)
  end
  def draw(xpos,ypos)
    image.draw(xpos,ypos,0)
  end
  
  def passable?
    !!@passable
  end
  
  OutOfBounds = new(passable: false, color: 0, name: "out_of_bounds")
  Grass = new(name: "grass")
  
end