class Player < Unit
  
  attr_accessor :weapon_count
  attr_reader :health, :max_health, :weapon
  def initialize(health: 3, weapon_count: 20)
    @weapon_count = weapon_count
    @weapon = Weapon.new("rock")
    @facing = :south
    @keys = 0
    super
  end
  
  def player?
    true
  end
  
  def throw_distance
    3
  end
  
  def move(dir)
    @facing = dir
    super
  end
  
  def throw_weapon(dir)
    @facing = dir
    if weapon_count > 0
      self.weapon_count -= 1
      distance = 0
      target = ([dir] * throw_distance).inject(@cell) do |cell,dir|
        distance += 1 
        next_cell = cell.neighbor_in_direction(dir)
        break next_cell unless next_cell.passable?(weapon)
        next_cell
      end
      
      bullet = @weapon.bullet
      
      anim = MovementAnimation.new(bullet,@cell,target,distance*100)
      $game.schedule_animation(anim) do
        target.occupant.attacked(nil) if target.occupant
        end_turn!
      end
    else
      #TODO: Display message about lacking weapons
    end
  end
  
  def ran_into(cell,direction,&callback)
    if cell.prop&.can_push?(direction)
      push(cell,direction,&callback)
    else
      #super
    end
  end
  
  def push(cell,direction,&callback)
    cell.prop.move(direction)
    anim = MovementAnimation.new(self,@cell,cell,$game.animation_duration)
    $game.schedule_animation(anim) do
      self.position = cell
      callback.call if callback
    end
  end
  
  def gain_key
    @keys += 1
  end
  
  def lose_key
    raise unless has_key?
    @keys -= 1
  end
  
  def has_key?
    @keys > 0
  end
  
  def attacked(enemy)
    take_damage(1)
  end
  
  def take_damage(*args)
    MediaManager.play_sfx("player_hurt")
    super
  end
  
  
  def end_turn!
    $game.game_state = GameState::EnemyAction.new($game)
  end
  
  def die
    $game.player_died
  end
  
  def imagename
    frame = ((Gosu.milliseconds % 1000) / 500) + 1
    "player_#{@facing}_#{frame}"
  end
  
end