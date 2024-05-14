def roll_dices(dice_count)
  roll = []
  dice_count.times { roll << rand(6) + 1 }
  roll.sort!
  puts "Here is your throw:"
  roll.each_with_index do |dice, index|
    puts (index + 1).to_s + ": " + dice.to_s
  end
  return roll
end

def pick_dices(dices_array)
  puts "Which dice(s) would you like to keep?"
  keeper_string = gets.chomp
  if keeper_string.empty?
    puts "You decided not to keep anything"
    return []
  else
    dices_to_keep = keeper_string.scan(/\d/)
    # handle 1. numbers higher than allowed 2. more items that allowed 3. no numbers
    scores_to_keep = []
    dices_to_keep.each { |dice| scores_to_keep << dices_array[dice.to_i - 1] }
    puts "You decided to keep #{list_string(scores_to_keep)}" # handle incorrect
    return scores_to_keep
  end
end
