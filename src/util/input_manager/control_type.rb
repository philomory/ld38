class InputManager
  class ControlType
    include Gosu
    
    attr_reader :queued_input
    def initialize
      @queued_input = []
      setup_bindings
    end
    
    def queue_input(action)
      @queued_input.push(action) if @queued_input.empty?
    end
  end
end