module DashboardHelper

  def team_description(game, index)
    if index == 1 && !game.team1.nil?
      return game.team1.name
    elsif index == 1
      if (game.duel1.include? "A") || (game.duel1.include? "B") || (game.duel1.include? "C") || (game.duel1.include? "D") || (game.duel1.include? "E") || (game.duel1.include? "F") || (game.duel1.include? "G") 
      	if game.duel1[0].to_i == 1
      	  return "Primeiro do Grupo " + game.duel1[1].to_s
      	elsif game.duel1[0].to_i == 2
      	  return "Segundo do Grupo " + game.duel1[1].to_s
      	end
      else
      	return "Vencedor do jogo " + game.duel1.to_s
      end
    elsif index == 2 && !game.team2.nil?
      return game.team2.name
    else
      if (game.duel2.include? "A") || (game.duel2.include? "B") || (game.duel2.include? "C") || (game.duel2.include? "D") || (game.duel2.include? "E") || (game.duel2.include? "F") || (game.duel2.include? "G") 
      	if game.duel2[0].to_i == 1
      	  return "Primeiro do Grupo " + game.duel2[1].to_s
      	elsif game.duel2[0].to_i == 2
      	  return "Segundo do Grupo " + game.duel2[1].to_s
      	end
	  else
	  	return "Vencedor do jogo " + game.duel2.to_s
	  end
    end
  end

end
