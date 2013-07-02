class Ranking
  include ActiveModel::Conversion
  extend ActiveModel::Naming

  attr_accessor :position, :position_old, :groups, :points, :team_id, :team_name, :games, :victory, :draw, :defeat, :gols_for, :gols_against, :gols_balance, :rule_id

  public

  def persisted?
  	false
  end

  def self.buildRanking(champ)
    teams = Game.find_by_sql("SELECT DISTINCT team.team_id, team.team_name, team.groups
                                FROM (SELECT DISTINCT games.team1_id AS team_id, teams.name as team_name, games.groups
                                        FROM games, teams
                                       WHERE games.championship_id = " + champ.id.to_s + "
                                         AND games.phase_id = " + 1.to_s + "
                                         AND teams.id = games.team1_id
                                      UNION
                                      SELECT DISTINCT games.team2_id AS team_id, teams.name as team_name, games.groups
                                        FROM games, teams
                                       WHERE games.championship_id = " + champ.id.to_s + "
                                         AND games.phase_id = " + 1.to_s + "
                                         AND teams.id = games.team2_id) team
                               ORDER BY team.groups, team.team_name, team.team_id")
    
    ranking = Array.new
    teams.each do |t|
      rank = Ranking.new
      rank.rule_id = champ.rule_id
      rank.team_id = t.team_id
      rank.team_name = t.team_name
      rank.groups = t.groups
      rank.position = 0
      rank.games = 0
      rank.points = 0
      rank.victory = 0
      rank.defeat = 0
      rank.draw = 0
      rank.gols_for = 0
      rank.gols_against = 0
      rank.gols_balance = 0
      ranking << rank
    end

    games = Game.where("games.championship_id = ? AND games.placar1 IS NOT NULL AND games.placar2 IS NOT NULL", champ.id)
    games.each do |g|
      r1 = find_team(ranking, g.team1_id)
      r2 = find_team(ranking, g.team2_id)
      
      if g.placar1 > g.placar2
        r1.points = r1.points + 3
        r1.victory = r1.victory + 1

        r2.defeat = r2.defeat + 1
      elsif g.placar2 > g.placar1
        r2.points = r2.points + 3
        r2.victory = r2.victory + 1

        r1.defeat = r1.defeat + 1
      else
        r1.points = r1.points + 1
        r1.draw = r1.draw + 1

        r2.points = r2.points + 1
        r2.draw = r2.draw + 1
      end
      r1.games = r1.games + 1
      r1.gols_for = r1.gols_for + g.placar1
      r1.gols_against = r1.gols_against + g.placar2
      r1.gols_balance = r1.gols_for - r1.gols_against

      r2.games = r2.games + 1
      r2.gols_for = r2.gols_for + g.placar2
      r2.gols_against = r2.gols_against + g.placar1
      r2.gols_balance = r2.gols_for - r2.gols_against

      update_team(ranking, r1)
      update_team(ranking, r2)
    end

    update_position(ranking)
    
    games = ranking
    ranking = Array.new

    groups = Game.find_by_sql("SELECT DISTINCT games.groups FROM games WHERE games.championship_id = " + champ.id.to_s)
    groups.each do |gr|
      for i in 1..games.count + 1
        games.each do |g|
          if g.position == i && g.groups == gr.groups
            ranking << g
            break
          end
        end
      end
    end

    return ranking
  end

  private
  
  def self.update_team(games, game)
    games.each do |g|
      if g.team_id == game.team_id
        g = game
        break
      end
    end
  end
  
  def self.find_team(games, team_id)
    games.each do |g|
      if g.team_id == team_id
        return g
      end
    end
  end

  def self.update_position(games)
    groups = nil
    count = 1
    games.each do |g|
      if groups != g.groups
        count = 1
      end
      g.position = count
      count = count + 1
      groups = g.groups
    end

    games.each do |g|
      games.each do |j|
        if ((g.points > j.points) ||
            (g.points == j.points && g.gols_balance > j.gols_balance) ||
            (g.points == j.points && g.gols_balance == j.gols_balance && g.gols_for > j.gols_for)) &&
           g.position > j.position &&
           g.groups == j.groups
          position = g.position
          g.position = j.position
          j.position = position
        end
      end
    end
    games.each do |g|
      games.each do |j|
        if ((g.points > j.points) ||
            (g.points == j.points && g.gols_balance > j.gols_balance) ||
            (g.points == j.points && g.gols_balance == j.gols_balance && g.gols_for > j.gols_for)) &&
           g.position > j.position &&
           g.groups == j.groups
          position = g.position
          g.position = j.position
          j.position = position
        end
      end
    end
  end

end