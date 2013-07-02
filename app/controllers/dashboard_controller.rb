class DashboardController < ApplicationController
  def show
  	@champ = Championship.find(params[:id])
    
    phase = params[:phase].to_i
    if phase == 0
      phase = 1
    end

    if phase == 2
      @games = Game.find_games_playoffs(@champ)
    else
      @games = Game.find_games_perpage(@champ, params[:page])

      @ranking = Ranking.buildRanking(@champ)
    end
  end

  def updategame
    @game = Game.find(params[:game_id])
    @game.placar1 = params[:placar1]
    @game.placar2 = params[:placar2]
    @game.save

    redirect_to :back
  end
end
