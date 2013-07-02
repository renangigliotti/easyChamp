class Game < ActiveRecord::Base
  attr_accessible :championship_id, :groups, :phase_id, :placar1, :placar2, :stage, :team1_id, :team2_id, :duel
  
  belongs_to :team1, :foreign_key => "team1_id", :class_name => "Team"
  belongs_to :team2, :foreign_key => "team2_id", :class_name => "Team"
  belongs_to :phase
  belongs_to :championship

  def self.find_games_perpage(championship, page)
    pages = Game.where(:championship_id => championship.id, :stage => "Rodada 1").count
    
    return Game.where(:championship_id => championship.id, :phase_id => 1).order("games.stage").paginate(:page => page, :per_page => pages)
  end

  def self.find_games_playoffs(championship)
    @championship = championship

    buildPlayoffs

    return @games = Game.where(:championship_id => @championship.id, :phase_id => 2)
  end

  def self.buildPlayoffs
    @ranking = Ranking.buildRanking(@championship)
  end

  private

  def self.find_team(position, groups)
    @ranking.each do |r|
      if r.position == position && r.groups == groups
        return Team.find(r.team_id)
      end
    end
  end

end
