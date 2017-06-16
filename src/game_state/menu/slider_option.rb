class GameState
  class Menu
    class SliderOption < Option
      attr_reader :current_value
      def initialize(text, min_value, current_value, max_value, action)
        @text, @min_value, @current_value, @max_value, @action = text, min_value, current_value, max_value, action
      end
      
      def text
        pre = @current_value > @min_value ? "<" : " "
        pos = @current_value < @max_value ? ">" : " "
        "#{pre} #{@text}: #{@current_value} #{pos}"
      end
      
      def incr!
        if @current_value < @max_value
          @current_value += 1
          @action.call(@current_value)
        end
      end
      
      def decr!
        if @current_value > @min_value
          @current_value -= 1
          @action.call(@current_value)
        end
      end
    end
  end
end