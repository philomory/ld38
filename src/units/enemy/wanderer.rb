class Enemy::Wanderer < Enemy
  def make_your_move(&blk)
    move(%i(north south east west).sample,&blk)
  end
end
