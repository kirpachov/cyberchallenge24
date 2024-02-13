# ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]
# Oleksandr Kirpachov, cyberchallenge 13 feb 24

class Scenario
  attr_accessor :limit, :numbers

  def initialize(limit, numbers)
    @limit = limit
    @numbers = numbers
  end

  def diff(a, b)
    (a - b).abs
  end

  def can_add?(new_number)
    numbers.all? do |num|
      diff(new_number, num) <= limit
    end
  end

  def all_can_add(new_numbers)
    new_numbers.filter { |num| can_add?(num) }
  end
end

cases = []

gets.to_i.times do
  cases << { limit: gets.gsub(/\n/, '').split(' ').last.to_i, numbers: gets.split(' ').map(&:to_i) }
end

cases.map do |casee|
  best = 2

  casee[:numbers].each do |number|
    free_numbers = casee[:numbers] - [number]
    scenario0 = Scenario.new(casee[:limit], [number])
    # set1 = []

    scenario0.numbers += scenario0.all_can_add(free_numbers)
    free_numbers -= scenario0.all_can_add(free_numbers)

    free_numbers.each do |free|
      free_for_second_scenario = free_numbers.map(&:to_i)
      scenario1 = Scenario.new(casee[:limit], [free])
      free_for_second_scenario -= [free]

      scenario1.numbers += scenario1.all_can_add(free_for_second_scenario)

      best_so_far = scenario1.numbers.count + scenario0.numbers.count
      best = best_so_far if best_so_far > best
    end
  end
  puts best
end

