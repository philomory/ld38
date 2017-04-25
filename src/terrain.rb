class Terrain
  def self.register(name,object)
    @registry ||= {}
    @registry[name] = object
  end
  
  def self.[](tag)
    @registry[tag]
  end
    
  
  attr_reader :name
  def initialize(name:, passable: true,bullet_passable: passable)
    @name, @passable, @bullet_passable = name, passable, bullet_passable
    Terrain.register(name,self)
  end
  def imagename
    name
  end
  def image
    MediaManager.image(imagename)
  end
  def draw(xpos,ypos)
    image.draw(xpos,ypos,0)
  end
  
  def passable?(passer)
    case passer
    when Weapon, Bullet then !!@bullet_passable
    else !!@passable
    end
  end
  
  OutOfBounds = new(passable: false, name: "out_of_bounds")
  Dirt = new(name: "dirt")
  Grass = new(name: "grass")
  Wall = new(name: "wall", passable: false)
  Floor = new(name: "floor")
  Empty = new(name: "empty", passable: false, bullet_passable: true)
  
end