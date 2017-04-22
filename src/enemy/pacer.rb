class Pacer < Enemy
  def initialize(*args)
    super
    @facing = :north
  end
  
  def make_your_move
    move(@facing)
  end
  
  def ran_into(cell)
    super
    @facing = -@facing
  end
  
end
