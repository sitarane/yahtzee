def separator
  puts ''
  puts '#######'
  puts ''
end

def get_input(comparison_object = nil)
  input = gets.chomp
  correct = input
  until correct.empty?
    if comparison_object
      #binding.pry
      puts "You chose #{comparison_object[input.to_i - 1]}. Correct?"
    else
      puts "You entered #{input}. Correct?"
    end
    correct = gets.chomp
    input = correct unless correct.empty?
  end
  return input
end

def list_string(array)
  string = ""
  array.each_with_index do |item, index|
    if index == 0
      string += item.to_s
    elsif index == array.length - 1
      string += " and #{item.to_s}"
    else
      string += ", #{item.to_s}"
    end
  end
  return string
end

def winner_list_string(players)
  string = ""
  players.each do |player|
    string += player[:name] + " with " + player[:score].values.sum.to_s + " points, "
  end
  string
end

def end_of_round_comment(sorted_players_with_scores)
  score_gaps = get_score_gaps(sorted_players_with_scores)
  outlier = analyse_score_gaps(score_gaps)
  if outlier == :lowest
    return "#{sorted_players_with_scores.first[0]} is lagging but not all hope is lost!"
  elsif outlier == :highest
    return "Everyone gang up against #{sorted_players_with_scores.last[0]} who's winning way too hard!"
  else
    return "Pretty even game so far, yawn..."
  end
end

def get_score_gaps(sorted_players_with_scores)
  gaps = []
  previous_player_score = sorted_players_with_scores.first[1]
  sorted_players_with_scores.drop(1).each do |player|
    current_player_score = player[1]
    gap = player[1] - previous_player_score
    gaps << gap
    previous_player_score = current_player_score
  end
  return gaps
end

def analyse_score_gaps(gaps_array)
  average_gap = gaps_array.sum / gaps_array.length
  largest_gap = gaps_array.max
  return nil if largest_gap < 1.5 * average_gap
  return :lowest if largest_gap == gaps_array.first
  return :highest if largest_gap == gaps_array.last
  return nil
end
