# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]
# Oleksandr Kirpachov, cyberchallenge 13 feb 24

instruction_index = 0

class Memory
  class << self
    def get(name)
      @variables ||= {}
      @variables[name]
    end

    def set(name, value)
      @variables ||= {}
      @variables[name] = value
    end
  end
end

class Instruction
  attr_reader :text, :row

  def initialize(text, row)
    @text = text
    @row = row
  end

  def parts
    @text.split(' ')
  end

  def operation
    parts.first
  end

  def exec_lab
    # Save in memory
    # lab xm
    # { xm: <row> }
    Memory.set(parts[1], row)
  end

  def exec_add
    # Get value from memory. Add new value. Save to memory.
    # add e 33
    current_value = Memory.get(parts[1]).to_i # or to f ??
    current_value += parts[2].to_i
    Memory.set(parts[1], current_value)
  end

  def exec_sub
    current_value = Memory.get(parts[1]).to_i # or to f ??
    current_value -= parts[2].to_i
    Memory.set(parts[1], current_value)
  end

  def exec_mul
    # Read from memory, multiply, save to memory.
    # mul a 48
    current_value = Memory.get(parts[1]).to_i # or to f ??
    current_value *= parts[2].to_i
    Memory.set(parts[1], current_value)
  end

  def exec_jmp
    Memory.get(parts[1]) == parts[2].to_i ? Memory.get(parts[3]).to_i : row + 1
  end

  def run
    # puts "Executing #{text} at row #{row}"

    return exec_jmp if operation == 'jmp'

    case operation
    when 'lab' then exec_lab
    when 'sub' then exec_sub
    when 'add' then exec_add
    when 'mul' then exec_mul
    end

    row + 1
  end
end

instructions = []

gets.to_i.times do
  instructions << Instruction.new(gets.gsub(/\n/, ''), instructions.length)
end

loop do
  instruction = instructions[instruction_index]
  break unless instruction.is_a?(Instruction)

  instruction_index = instruction.run
end

sum = 0
%w[a b c d e f].each do |variable|
  sum += Memory.get(variable).to_i # to_f ???
end

puts sum

# cat emulation-input-0.txt | ruby emulation.rb > output-0.txt && diff output-0.txt emulation-output-0.txt