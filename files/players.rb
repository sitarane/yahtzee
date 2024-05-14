def get_players
  players = Array.new
  2.times do
    puts "Who will be playing? Enter your name."
    name = get_input
    # handle empty strings and same name as previous player	
    players << { name: name, score: {} }
  end
  
  loop do
    puts "#{list_string(player_names(players))} are playing."
    puts "Any more players? (leave empty if everyone's there)"
    name = get_input
    break if name.empty?
    players << { name: name, score: {} }
  end
  return players
end

def player_names(players)
  names = Array.new
  players.each do |player|
    names << player[:name]
  end
  return names
end
