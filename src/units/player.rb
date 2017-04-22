class Player < Unit
  
  attr_accessor :weapon_count
  def initialize(health: 3, weapon_count: 20)
    @health, @weapon_count = health, weapon_count
    p weapon_count
    p self.weapon_count
  end
  
  def player?
    true
  end
  
  def throw_distance
    3
  end
  
  def throw_weapon(dir)
    if weapon_count > 0
      self.weapon_count -= 1
      target = ([dir] * throw_distance).inject(@cell) do |cell,dir| 
        next_cell = cell.neighbor_in_direction(dir)
        break next_cell if next_cell.blocked?
        next_cell
      end
    
      target.occupant.attacked(nil) if target.occupant
      
      end_turn!
    else
      #TODO: Display message about lacking weapons
    end
    
  end
  
  def end_turn!
    $game.game_state = GameState::EnemyAction.new($game)
  end
  
  def die
    $game.player_died
  end
  
end