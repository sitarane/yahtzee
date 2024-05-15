def roll_dices(dice_count)
  roll = []
  dice_count.times { roll << rand(6) + 1 }
  roll.sort!
  puts "Here is your throw:"
  roll.each { |dice| puts dice.to_s }
  return roll
end

def pick_dices(dices_array)
  puts "Which dice(s) would you like to keep?"
  keeper_string = gets.chomp
  if keeper_string.empty?
    puts "You decided not to keep anything"
    return []
  else
    candidates = keeper_string.scan(/\d/).map(&:to_i)
    checked_candidates = (candidates & dices_array).flat_map do |n|
      [n]*[candidates.count(n), dices_array.count(n)].min
    end
    checked_candidates = candidates
    # handle 1. numbers higher than allowed 2. more items that allowed 3. no numbers
    puts "You decided to keep #{list_string(checked_candidates)}" # handle incorrect
    return checked_candidates
  end
end
