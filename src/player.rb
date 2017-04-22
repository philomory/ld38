class Player < Unit
  def player?
    true
  end
  
  def throw_distance
    3
  end
  
  def throw_weapon(dir)
    target = ([dir] * throw_distance).inject(@cell) do |cell,dir| 
      next_cell = cell.neighbor_in_direction(dir)
      break next_cell if next_cell.blocked?
      next_cell
    end
    
    target.occupant.attacked if target.occupant
      
  end
end