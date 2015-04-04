class DashboardController < ApplicationController
  
  def show
  	@championship = Championship.find(params[:championship_id])
    
    phase = params[:phase].to_i
    if phase == 0
      phase = 1
    end

    if @championship.rule_id == 3
      @games = @championship.games.find_games_playoffs(@championship)
      @games = @championship.games
    else 
      if phase == 2
        @games = @championship.games.find_games_playoffs(@championship)
      else
        @games = @championship.games.find_games_perpage(@championship, params[:page])
      end

      @ranking = Ranking.buildRanking(@championship)
    end
  end

  def updategame
    @championship = Championship.find(params[:championship_id])
    
    @game = @championship.games.find(params[:game_id])
    @game.placar1 = params[:placar1]
    @game.placar2 = params[:placar2]
    @game.save

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Game ' + @game.id.to_s + ' was successfully updated.' }
    end
  end
end
