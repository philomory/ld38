class Symbol
  def -@
    case self
    when :north then :south
    when :south then :north
    when :east then :west
    when :west then :east
    else raise NoMethodError, "undefined method `-@' for #{self.inspect}:Symbol"
    end
  end
end


