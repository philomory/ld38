class Enemy::Pacer < Enemy
  def initialize(*args)
    super
    @facing = :north
  end
  
  def make_your_move(&blk)
    move(@facing,&blk)
  end
  
  def ran_into(cell,direction)
    super
    @facing = -@facing
  end
  
  def imagename
    frame = ((Gosu.milliseconds % 1000) / 500) + 1
    "pacer_#{@facing}_#{frame}"
  end
  
end
