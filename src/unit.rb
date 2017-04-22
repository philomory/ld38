class Unit
  def initialize
  end
  
  def position=(new_cell)
    raise new_cell.to_s if new_cell && new_cell.blocked?
    @cell.occupant = nil if @cell
    @cell = new_cell
    @cell.occupant = self if @cell
  end
    
  def move(direction)
    target = @cell.neighbor_in_direction(direction)
    if target.passable?
      self.position = target
    else
      ran_into(target)
    end
  end
  
  def ran_into(cell)
    puts "Ran into something"
  end
  
  def imagename
    self.class.name.split("::").last.downcase
  end
  
  def image
    ImageManager.image(imagename)
  end
  
  def draw(xpos,ypos)
    image.draw(xpos,ypos,1)
  end
  
  def player?
    false
  end
  
  def attacked
    puts "I was attacked!"
  end
  
end