class Game < ActiveRecord::Base
  attr_accessible :championship_id, :groups, :phase_id, :placar1, :placar2, :stage, :team1_id, :team2_id, :duel1, :duel2
  
  belongs_to :team1, :foreign_key => "team1_id", :class_name => "Team"
  belongs_to :team2, :foreign_key => "team2_id", :class_name => "Team"
  belongs_to :phase
  belongs_to :championship

  def self.find_games_perpage(championship, page)
    stages = Game.select("DISTINCT games.stage").where(:championship_id => championship.id, :phase_id => 1)
    pages = Game.where(:championship_id => championship.id, :stage => stages[0].stage).count
    
    return Game.where(:championship_id => championship.id, :phase_id => 1).order("games.stage").paginate(:page => page, :per_page => pages)
  end

  def self.find_games_playoffs(championship)
    @championship = championship

    buildPlayoffs

    return @games = Game.where(:championship_id => @championship.id, :phase_id => 2)
  end

  def self.buildPlayoffs
    games = Game.where(:championship_id => @championship.id, :phase_id => 2).order(:id)

    games.each do |g|
      if (g.duel2.include? "A") || (g.duel2.include? "B") || (g.duel2.include? "C") || (g.duel2.include? "D") || (g.duel2.include? "E") || (g.duel2.include? "F") || (g.duel2.include? "G") || (g.duel2.include? "H") || (g.duel2.include? "I") || (g.duel2.include? "J") || (g.duel2.include? "K") || (g.duel2.include? "L") || (g.duel2.include? "M") 

        game = Game.find(g.id)

        count = Game.where(:championship_id => @championship.id, :phase_id => 1, :groups => g.duel1[1], :placar1 => nil, :placar2 => nil).count
        if count > 0
          game.team1_id = nil
          game.team2_id = nil
          game.placar1 = nil
          game.placar2 = nil
          game.save
          next
        end

        count = Game.where(:championship_id => @championship.id, :phase_id => 1, :groups => g.duel2[1], :placar1 => nil, :placar2 => nil).count
        if count > 0
          game.team1_id = nil
          game.team2_id = nil
          game.placar1 = nil
          game.placar2 = nil
          game.save
          next
        end

        ranking = Ranking.buildRanking(@championship)
        game.team1_id = self.find_team(ranking, g.duel1[0], g.duel1[1])
        game.team2_id = self.find_team(ranking, g.duel2[0], g.duel2[1])
        game.save
      else
        game = Game.find(g.id)

        if g.duel1.to_i < 0
          duel1 = g.duel1.to_i * -1
        else
          duel1 = g.duel1
        end

        game1 = Game.find(duel1)
        if game1.placar1.nil? || game1.placar2.nil?
          game.placar1 = nil
          game.placar2 = nil
          game.team1_id = nil
        end

        if g.duel2.to_i < 0
          duel2 = g.duel2.to_i * -1
        else
          duel2 = g.duel2
        end

        game2 = Game.find(duel2)
        if game2.placar1.nil? || game2.placar2.nil?
          game.placar1 = nil
          game.placar2 = nil
          game.team2_id = nil
        end

        if g.duel1.to_i < 0
          game.team1_id = self.find_team_loser(game1)
        else
          game.team1_id = self.find_team_victory(game1)
        end

        if g.duel2.to_i < 0
          game.team2_id = self.find_team_loser(game2)
        else
          game.team2_id = self.find_team_victory(game2)
        end

        game.save
      end
    end
  end

  private

  def self.find_team(ranking, position, groups)
    ranking.each do |r|
      if r.position.to_i == position.to_i && r.groups.to_s == groups.to_s
        return r.team_id
      end
    end
  end

  def self.find_team_victory(game)
    if game.placar1.nil? || game.placar2.nil?
      return nil
    end

    if game.placar1 > game.placar2
      return game.team1_id
    elsif game.placar2 > game.placar1
      return game.team2_id
    end
  end

  def self.find_team_loser(game)
    if game.placar1.nil? || game.placar2.nil?
      return nil
    end

    if game.placar1 < game.placar2
      return game.team1_id
    elsif game.placar2 < game.placar1
      return game.team2_id
    end
  end

end