class WarpPoint < Prop
  
  register_type("WarpPoint",self)
  
  attr_reader :tag, :partner
  def initialize(properties)
    raise if properties[:tag].nil?
    super
    #TODO: Figure out how to handle throwing rocks through warp-points. For now, can't be done.
    @blocks_player = @blocks_enemy = false
    @tag = properties[:tag]
  end
  
  def other=(other)
    raise "#{self} already has a match!" unless @partner.nil?
    raise "#{other} does not share tag with #{self}" unless @tag == other.tag 
    @partner = other
  end
  
  def to_s
    "WarpPoint[#{@tag}]"
  end
  
  def imagename
    Gosu.milliseconds % 1000 >= 500 ? "warp_1" : "warp_2" 
  end

  def on_enter(unit)
    if @arriving == unit
      @arriving = nil
    else
      @partner.prepare_for_arrival(unit)
      unit.position = @partner.cell
    end
  end
  
  def prepare_for_arrival(unit)
    @arriving = unit
  end
  

  
end