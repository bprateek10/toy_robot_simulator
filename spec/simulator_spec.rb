require "simulator"
require 'pry'

describe Simulator do
  context "read_file" do
    it "should read file" do
      simulator = Simulator.new('./spec/test_data/test.txt')
      expect(simulator.read_file).to eq(["place 0,0,north\n", "right\n", "report"])
    end
    
    it "should throw error for invalid path" do
      simulator = Simulator.new('./spec/test_data/testt.txt')
      expect(simulator.read_file).to eq('File not found')
    end
  end

  context "execute_comands" do
    it "should return error if no commands are passed" do
      simulator = Simulator.new('./spec/test_data/empty_file.txt')
      simulator.read_file
      expect(simulator.execute_commands).to eq('No Commands found!')  
    end

    it "should return error if first command is not place command" do
      simulator = Simulator.new('./spec/test_data/first_no_place_command.txt')
      simulator.read_file
      expect(simulator.execute_commands).to eq('First place the toy on board')  
    end

    it "should return error if toy is placed outside board" do
      simulator = Simulator.new('./spec/test_data/place_toy_outside_board.txt')
      simulator.read_file
      expect(simulator.execute_commands).to eq('Toy not placed on the board')  
    end

    it "should return expected result" do
      simulator = Simulator.new('./spec/test_data/test.txt')
      simulator.read_file
      expect(simulator.execute_commands).to eq('0, 0, west')  
    end
  end
end
