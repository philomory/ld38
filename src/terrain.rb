class Terrain
  def self.register(name,object)
    @registry ||= {}
    @registry[name] = object
  end
  
  def self.[](tag)
    @registry[tag]
  end
    
  
  attr_reader :name
  def initialize(name:, passable: true)
    @name, @passable = name, passable
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
  
  def passable?(passer)
    !!@passable
  end
  
  OutOfBounds = new(passable: false, name: "out_of_bounds")
  Dirt = new(name: "dirt")
  Grass = new(name: "grass")
  Wall = new(name: "wall", passable: false)
  
end