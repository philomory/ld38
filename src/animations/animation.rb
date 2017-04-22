class Animation
  def initialize(duration)
    @__duration = duration.to_f
  end
  
  def update
    finish if time_spent > @__duration
  end
  
  def draw
  end
  
  def play!(&callback)
    @__callback = callback
    @started = true
    @__start_time = Gosu.milliseconds
    on_start
  end
  
  def time_spent
    Gosu.milliseconds - @__start_time
  end
  
  def portion
    time_spent / @__duration 
  end
  
  def started?
    @started
  end
  
  def finished?
    @finished
  end
  
  def playing?
    started? && !finished?
  end
  
  def finish
    @finished = true
    on_end
    @__callback.call
  end
  
  def on_start
  end
  
  def on_end
  end
end