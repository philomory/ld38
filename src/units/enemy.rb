class Enemy < Unit

  def initialize
    super
    @ready_to_move = false
  end

  def ready_to_move!
    @ready_to_move = true
  end
  
  def ready_to_move?
    @ready_to_move
  end
  
  def make_your_move!(&callback)
    make_your_move(&callback)
    @ready_to_move = false
  end
  
  def make_your_move
  end
  
  def ran_into(cell)
    if cell.occupant && cell.occupant.player?
      puts "Attacking player"
    end
  end
  
  def attacked(weapon)
    take_damage(1)
  end
  
  def die
    @cell.occupant = nil
    $game.enemy_died(self)
  end
  
end
