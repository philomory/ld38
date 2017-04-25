class Enemy < Unit
  self.z_index = 1
  
  
  def self.new(*args)
    if self == Enemy
      self.const_get(args.shift).new(*args)
    else
      super
    end
  end

  def initialize(*args)
    super()
    @ready_to_move = false
    @turns_stunned = 0
  end

  def ready_to_move!
    @ready_to_move = true
  end
  
  def ready_to_move?
    @ready_to_move
  end
  
  def make_your_move!(&callback)
    make_your_move(&callback) unless stunned?
    end_turn
  end
  
  def make_your_move
  end
  
  def die
    @cell.occupant = nil
    $game.enemy_died(self)
  end
  
  def ran_into(cell,direction,&callback)
    if cell.occupant && cell.occupant.player?
      attack(cell.occupant)
    end
    callback.call if callback
  end
  
  def attack(player)
    player.attacked(self)
  end
  
  def attacked(weapon)
    @turns_stunned = 4
    MediaManager.play_sfx("enemy_stunned")
  end
  
  def stunned?
    @turns_stunned > 0
  end
  
  def draw(xpos,ypos)
    super
    draw_stars(xpos,ypos) if stunned? 
  end
  
  def draw_stars(xpos,ypos)
    MediaManager.image(star_image).draw(xpos,ypos, z_index)
  end
  
  def star_image
    frame = ((Gosu.milliseconds % 1000) / 500) + 1
    "star_#{[@turns_stunned,3].min}_#{frame}"
  end
  
  def end_turn
    @ready_to_move = false
    @turns_stunned -= 1 if stunned?
  end
  
  
  
end
