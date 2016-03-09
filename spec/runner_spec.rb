require './lib/robot.rb'

include ToyRobot

describe Robot do 
  let(:runner) { Robot.new }

  describe "REPORT" do
    it "should raise an exception when no robot has been placed" do
      expect { runner.report }.to raise_error RobotError
    end
    it "should report the postion and direction after a robot has been placed" do
      runner.place(0,0,:NORTH)
      expect(runner.report).to eq "0,0,NORTH"
    end
  end
  describe "PLACE" do
    it "should raise an exception if coordinates are negative" do
      expect { runner.place(-1,1,:NORTH) }.to raise_error RobotError
    end
    it "should raise an exception if coordinates are greater than 4" do
      expect { runner.place(5,1,:NORTH) }.to raise_error RobotError
    end
    it "should raise an exception if direction is invalid" do
      expect { runner.place(1,1,:OVERTHERE) }.to raise_error RobotError
    end
  end
  describe "MOVE" do
    it "should move the robot one unit north" do
      runner.place(0,0,:NORTH)
      runner.move
      expect(runner.report).to eq "0,1,NORTH"
    end
    it "should move the robot one unit east" do
      runner.place(0,0,:EAST)
      runner.move
      expect(runner.report).to eq "1,0,EAST"
    end
    it "should raise exception when moving robot south off the board" do
      runner.place(0,0,:SOUTH)
      expect { runner.move }.to raise_error RobotError
    end
  end
  describe "LEFT and RIGHT" do
    it "should rotate the robot right from north to east" do
      runner.place(0,0,:NORTH)
      runner.right
      expect(runner.report).to eq "0,0,EAST"
    end
    it "should rotate the robot left from east to north" do
      runner.place(0,0,:EAST)
      runner.left
      expect(runner.report).to eq "0,0,NORTH"
    end
    it "should rotate the robot left from north to west" do
      runner.place(0,0,:NORTH)
      runner.left
      expect(runner.report).to eq "0,0,WEST"
    end
    it "should rotate the robot right from west to north" do
      runner.place(0,0,:WEST)
      runner.right
      expect(runner.report).to eq "0,0,NORTH"
    end
  end
end
