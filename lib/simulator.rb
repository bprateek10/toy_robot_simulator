class Simulator
  X_LIMIT = 4
  Y_LIMIT = 4

  VALID_FACE_VALUES = ['north', 'south', 'east', 'west']

  def initialize(file_path)
    @file_path = file_path
    @commands = []
    @x_pointer = nil
    @y_pointer = nil
    @face = nil
  end

  def read_file
    begin
      @commands = File.readlines(@file_path) 
    rescue 
      p 'File not found'
    end
  end

  def execute_commands
    return 'No Commands found!' if @commands.empty?
    @commands.each_with_index do |command, index|
      command = command.chomp
      return 'First place the toy on board' if index == 0 && command.split(' ').first.downcase != 'place'
      place(command) if command.split(' ').first.downcase == 'place'
      move if command.downcase == 'move'
      left if command.downcase == 'left'
      right if command.downcase == 'right'
      return report if command.downcase == 'report'
    end
  end

  private

  def place(command)
    values = command.split(' ').last
    x,y,f = values.split(',')
    if x.to_i <= X_LIMIT && y.to_i <= Y_LIMIT && VALID_FACE_VALUES.include?(f.downcase)
      @x_pointer = x.to_i
      @y_pointer = y.to_i
      @face = f.downcase
    end
  end

  def move
    return 'Toy not placed on the board' if @x_pointer == nil || @y_pointer == nil
    if @face == 'north' && @y_pointer < Y_LIMIT
      @y_pointer += 1
    elsif @face == 'south' && @y_pointer != 0
      @y_pointer -= 1
    elsif @face == 'east' && @x_pointer < X_LIMIT
      @x_pointer += 1
    elsif @face == 'west' && @x_pointer != 0
      @x_pointer -= 1
    end
  end

  def left
    return 'Toy not placed on the board' if @x_pointer == nil || @y_pointer == nil
    if @face == 'north'
      @face = 'east' 
    elsif @face == 'south'
      @face = 'west' 
    elsif @face == 'east'
      @face = 'south' 
    elsif @face == 'west'
      @face = 'north'
    end
  end

  def right
    return 'Toy not placed on the board' if @x_pointer == nil || @y_pointer == nil
    if @face == 'north'
      @face = 'west' 
    elsif @face == 'south'
      @face = 'east' 
    elsif @face == 'east'
      @face = 'north' 
    elsif @face == 'west'
      @face = 'south'
    end
  end

  def report
    return 'Toy not placed on the board' if @x_pointer == nil || @y_pointer == nil
    "#{@x_pointer}, #{@y_pointer}, #{@face}"
  end
end
