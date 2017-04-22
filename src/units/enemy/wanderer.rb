class Wanderer < Enemy
  def make_your_move
    move %i(north south east west).sample
  end
end
