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
    end

    @ranking = Ranking.buildRanking(@champ)
  end

  def updategame
    @game = Game.find(params[:game_id])
    @game.placar1 = params[:placar1]
    @game.placar2 = params[:placar2]
    @game.save

    respond_to do |format|
      format.html { redirect_to :back, notice: 'Game ' + @game.id.to_s + ' was successfully updated.' }
    end
  end
end
