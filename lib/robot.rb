
module ToyRobot
  class RobotError < StandardError; end
  class Robot

    DIRECTIONS = [:NORTH,:EAST,:SOUTH,:WEST]

    def report
      if !placed?
        raise RobotError.new "No robot placed"
      end
      "#{@xPos},#{@yPos},#{@direction}"
    end

    def place(x,y,direction)
      if !valid_position?(x,y)
        raise RobotError.new "Coordinates #{x},#{y} are invalid"
      end

      if !DIRECTIONS.include?(direction)
        raise RobotError.new "Direction #{direction} is invalid"
      end

      @xPos,@yPos,@direction = x,y,direction
    end

    def move
      x,y = @xPos,@yPos

      case @direction
      when :NORTH
        y += 1
      when :EAST 
        x += 1
      when :SOUTH
        y -= 1
      when :WEST
        x -= 1
      end

      if !valid_position?(x,y)
        raise RobotError.new "Coordinates #{x},#{y} are invalid"
      end

      @xPos,@yPos = x,y
    end

    def right
      rotate(:RIGHT)
    end

    def left
      rotate(:LEFT)
    end

    private

    def rotate(way)
      idx = DIRECTIONS.index(@direction)

      case way
      when :RIGHT
        idx += 1
        idx -= 4 if idx > 3
      when :LEFT
        idx -= 1
        idx += 4 if idx < 0
      end

      @direction = DIRECTIONS[idx]
    end

    def valid_position?(x,y)
      x > -1 && y > -1 && x < 5 && y < 5
    end

    def placed?
      @xPos && @yPos && @direction
    end

  end
end
