require 'forwardable'

class Bullet < GameObject
  extend Forwardable
  
  self.z_index = 3
  
  def initialize(weapon)
    @weapon = weapon
  end
  
  def imagename
    "#{@weapon.name}_bullet"  
  end
  
end