require_relative 'simulator'

file_path = gets.chomp
simulator = Simulator.new(file_path)
simulator.read_file
p simulator.execute_commands
