class Player < Unit
  def player?
    true
  end
  
  def throw_distance
    3
  end
  
  def throw_weapon(dir)
    if weapon_count > 0
      target = ([dir] * throw_distance).inject(@cell) do |cell,dir| 
        next_cell = cell.neighbor_in_direction(dir)
        break next_cell if next_cell.blocked?
        next_cell
      end
    
      target.occupant.attacked if target.occupant
      end_turn!
    end
      
  end
  
  def die
    $game.player_died
  end
  
end