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

def end_of_round_comment(players)
  total_points = 0
  players.each do |player|
    total_points += player[:score].values.sum
  end
  top_player = players.select { |player| player[:score] > 1.5 * (total_points.to_f / players.length) }
end

def median(array)
  return nil if array.empty?
  sorted = array.sort
  len = sorted.length
  (sorted[(len - 1) / 2] + sorted[len / 2]) / 2.0
end

