module DashboardHelper

  def team_description(game, index)
    if index == 1 && !game.team1.nil?
      return game.team1.name
    elsif index == 1
      if (game.duel1.include? "A") || (game.duel1.include? "B") || (game.duel1.include? "C") || (game.duel1.include? "D") || (game.duel1.include? "E") || (game.duel1.include? "F") || (game.duel1.include? "G") 
        return game.duel1[0].to_s + "º Grupo " + game.duel1[1].to_s
      else
        if game.duel1.to_i < 0
          duel1 = game.duel1.to_i * -1
          return "Perd. " + duel1.to_s
        else
          return "Venc. " + game.duel1.to_s
        end
      end
    elsif index == 2 && !game.team2.nil?
      return game.team2.name
    else
      if (game.duel2.include? "A") || (game.duel2.include? "B") || (game.duel2.include? "C") || (game.duel2.include? "D") || (game.duel2.include? "E") || (game.duel2.include? "F") || (game.duel2.include? "G") || (game.duel2.include? "H") || (game.duel2.include? "I") || (game.duel2.include? "J") || (game.duel2.include? "K") || (game.duel2.include? "L") || (game.duel2.include? "M") 
        return game.duel2[0].to_s + "º Grupo " + game.duel2[1].to_s
	  else
      if game.duel2.to_i < 0
        duel2 = game.duel2.to_i * -1
        return "Perd. " + duel2.to_s
      else
        return "Venc. " + game.duel2.to_s
      end	  	
	  end
    end
  end

end
