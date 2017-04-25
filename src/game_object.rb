class GameObject
  class << self
    attr_accessor :z_index
  end
  
  self.z_index = 0
  
  attr_accessor :animating
  alias_method :animating?, :animating
  
  def image
    MediaManager.image(imagename)
  end
  
  def z_index
    self.class.z_index || 0
  end  
  
  def draw(xpos,ypos)
    image.draw(xpos,ypos,z_index)
  end
end