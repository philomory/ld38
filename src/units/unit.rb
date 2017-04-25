class Unit < GameObject
  def z_index
    1
  end
  
  
  attr_reader :health
  def initialize(health: 1,**kwargs)
    @max_health = @health = health
  end
  
  def position=(new_cell)
    return false if new_cell && new_cell.blocked?(self)
    #raise new_cell.to_s if new_cell && new_cell.blocked?(self)
    @cell.occupant = nil if @cell
    @cell = new_cell
    @cell.occupant = self if @cell
  end
    
  def move(direction,&callback)
    target = @cell.neighbor_in_direction(direction)
    if target.passable?(self)
      anim = MovementAnimation.new(self,@cell,target,$game.animation_duration)
      $game.schedule_animation(anim) do
        self.position = target
        callback.call if callback
      end
    else
      ran_into(target,direction,&callback)
    end
  end
  
  def ran_into(cell,direction,&callback)
    callback.call if callback
  end
  
  def imagename
    self.class.name.split("::").last.downcase
  end
  

  
  def player?
    false
  end
  
  def health=(value)
    @health = [value, @max_health].min
    die if @health <= 0
  end
  
  def die
    raise "Implement #die in #{self.class}!"
  end
  
  def attacked
    raise "Implement #attacked in #{self.class}!"
  end
  
  def get_stunned(turns)
  end
  
  def take_damage(amount)
    self.health -= amount
  end
  
  
end