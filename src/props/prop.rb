class Prop < GameObject
  
  Prototype = Struct.new(:pushable, :blocks_player, :blocks_enemy, :blocks_bullet, :imagename) do
    DEFAULTS = {pushable: false, blocks_player: true, blocks_enemy: true, blocks_bullet: true }
    def initialize(**kwargs)
      kwargs = DEFAULTS.merge(kwargs)
      args = members.map {|m| kwargs[m] }
      super(*args)
    end
  end
  
  PROTOTYPES = {
    prop: Prototype.new,
    stone: Prototype.new(pushable: true, imagename: "stone"),
    bush: Prototype.new(blocks_player: false, imagename: "bush")
  }
  
  self.z_index = 2
  
  SPECIFIC_TYPES = {}
  
  def self.register_type(key,klass)
    SPECIFIC_TYPES[key] = klass
  end
  
  def self.new(type, properties)
    if SPECIFIC_TYPES.has_key?(type) && self == Prop
      SPECIFIC_TYPES[type].new(type,properties)
    else
      super
    end
  end
  
  attr_reader :type, :pushable, :blocks_player, :blocks_enemy, :blocks_bullet
  def initialize(type, properties)
    @type = type.downcase.to_sym
    prototype = PROTOTYPES[@type]
    prototype.each_pair do |key, value|
      instance_variable_set(:"@#{key}", properties[key.to_s] || value )
    end
  end
  
  %i{pushable blocks_player blocks_enemy blocks_bullet}.each do |prop|
    alias_method :"#{prop}?", prop 
  end
  
  def position=(new_cell)
    raise new_cell.to_s if new_cell && new_cell.blocked?(self)
    @cell.prop = nil if @cell
    @cell = new_cell
    @cell.prop = self if @cell
  end
    
  def move(direction,&callback)
    target = @cell.neighbor_in_direction(direction)
    anim = MovementAnimation.new(self,@cell,target,$game.animation_duration)
    $game.schedule_animation(anim) do
      self.position = target
    end
  end
  
  def imagename
    @imagename || type.to_s.downcase
  end
  
  def on_enter(unit)
  end
  
  def can_push?(direction)
    pushable? && @cell.neighbor_in_direction(direction).room_for_prop?
  end
  
  def passable?(passer)
    case passer
    when Player then !blocks_player?
    when Enemy then !blocks_enemy?
    when Bullet, Weapon then !blocks_bullet?
    else raise ArgumentError
    end
  end
  
end