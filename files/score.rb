AVAILABLE_ROWS = {
    ones: { name: "Ones", hint: "Add up all the 1 dices" },
    twos: { name: "Twos", hint: "Add up all the 2 dices" },
    threes: { name: "Threes", hint: "Add up all the 3 dices" },
    fours: { name: "Fours", hint: "Add up all the 4 dices" },
    fives: { name: "Fives", hint: "Add up all the 5 dices" },
    sixes: { name: "Sixes", hint: "Add up all the 6 dices" },
    three_of_a_kind: { name: "Three of a kind", hint: "Add up all dices" },
    four_of_a_kind: { name: "Four of a kind", hint: "Add up all dices" },
    full_house: { name: "Full house", hint: "25 points" },
    small_straight: { name: "Small straight", hint: "30 points" },
    long_straight: { name: "Long straight", hint: "40 points" },
    yahtzee: { name: "Yahtzee", hint: "50 points the first time, 100 after" },
    chance: { name: "Chance", hint: "Add up all dices" }
  }

def show_rows(player, dices = nil)
  score = player[:score]
  puts "You have the following possibilities:"
  rows_to_remove = score.keys - [:yahtzee]
  remaining_rows = AVAILABLE_ROWS.except(*rows_to_remove)
  count = 1
  remaining_rows_array = Array.new
  remaining_rows.each do |key, item|
    estimation_string = ' = ' + score_as(key, dices, player).to_s + ' points' if dices
    puts count.to_s + ". " + item[:name] + " | " + item[:hint] + estimation_string if dices
    remaining_rows_array << key
    count += 1
  end
  return remaining_rows_array
end

def score_as(type, dices, player)
  case type
  when :ones
    return dices.count(1)
  when :twos
    return dices.count(2) * 2
    #dices.each { |dice| score += dice if dice == 2 }
  when :threes
    return dices.count(3) * 3
    #dices.each { |dice| score += dice if dice == 3 }
  when :fours
    return dices.count(4) * 4
    #dices.each { |dice| score += dice if dice == 4 }
  when :fives
    return dices.count(5) * 5
    #dices.each { |dice| score += dice if dice == 5 }
  when :sixes
    return dices.count(6) * 6
    #dices.each { |dice| score += dice if dice == 6 }
  when :three_of_a_kind
    candidate = dices.max_by { |i| dices.count(i) }
    return 0 unless dices.count(candidate) >= 3
    return dices.sum
  when :four_of_a_kind
    candidate = dices.max_by { |i| dices.count(i) }
    return 0 unless dices.count(candidate) >= 4
    return dices.sum
  when :full_house
    types_of_dices = dices.uniq
    return 0 unless types_of_dices.length == 2
    return 0 unless dices.count(types_of_dices.first) >= 2
    return 25
  when :small_straight
    return 30 if estimate_straight(dices, 4)
    return 0
  when :long_straight
    return 40 if estimate_straight(dices, 5)
    return 0
  when :yahtzee
    if dices.count(dices.first) == 5
      return 100 if player[:score][:yahtzee] && player[:score][:yahtzee] >= 50
      return 50
    end
    return 0
  when :chance
    return dices.sum
  end
end

def estimate_straight(dices, count)
  previous_dice = nil
  consecutive_count = 1
  dices.each do |dice|
    if previous_dice.nil?
      previous_dice = dice
    else
      if dice == previous_dice + 1
        consecutive_count += 1
        previous_dice = dice
        return true if consecutive_count >= count
      else
        consecutive_count = 1
        previous_dice = dice
      end
    end
  end
  return false
end

def score(dice_array, player)
  remaining_rows = show_rows(player, dice_array)
  puts "What would you like to score as?"
  comparison_object = {}
  remaining_rows.each_with_index do |key, index|
    comparison_object[index] = AVAILABLE_ROWS[key][:name]
  end
  selection = get_input(comparison_object) # handle weirderies
  selection_symbol = remaining_rows[selection.to_i - 1]
  puts "Scoring as #{AVAILABLE_ROWS[selection_symbol][:name]}"
  points = score_as(selection_symbol, dice_array, player)
  return { selection_symbol => points }
end
