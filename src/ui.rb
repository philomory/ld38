class UI
  Z_INDEX = 10
  
  def initialize(game)
    @game = game
  end
  
  def draw
    draw_health
    draw_weapon
  end
  
  def draw_health
    ImageManager.font("large").draw("Health: #{@game.player.health}/#{@game.player.max_health}",0,0,Z_INDEX)
  end
  
  def draw_weapon
    ImageManager.font("large").draw_rel("Weapon: #{@game.player.weapon.name} (#{@game.player.weapon_count})",800,0,Z_INDEX,1,0)
  end
  
  
end
