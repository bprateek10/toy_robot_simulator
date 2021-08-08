require_relative 'simulator'
p 'Input the command file path: '
file_path = gets.chomp
simulator = Simulator.new(file_path)
simulator.read_file
p simulator.execute_commands
