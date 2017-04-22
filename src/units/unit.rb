class Unit < GameObject
  attr_reader :health
  def initialize(health: 1,**kwargs)
    @max_health = @health = health
  end
  
  def position=(new_cell)
    raise new_cell.to_s if new_cell && new_cell.blocked?
    @cell.occupant = nil if @cell
    @cell = new_cell
    @cell.occupant = self if @cell
  end
    
  def move(direction,&callback)
    target = @cell.neighbor_in_direction(direction)
    if target.passable?
      anim = MovementAnimation.new(self,@cell,target,250)
      $game.game_state = GameState::PlayingAnimation.new($game,anim) do 
        self.position = target
        callback.call if callback
      end
    else
      ran_into(target)
      callback.call if callback
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
    puts "ouch!"
    self.health -= amount
  end
  
  
end