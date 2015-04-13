class GamesController < ApplicationController

  def index
    @championship = current_user.championships.find(params[:championship_id])
    @games = @championship.games.paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  def show
    @championship = current_user.championships.find(params[:championship_id])
    @game = @championship.games.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  def new
    @championship = current_user.championships.find(params[:championship_id])
    @game = @championship.games.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  def edit
    @championship = current_user.championships.find(params[:championship_id])
    @game = @championship.games.find(params[:id])
  end

  def create
    @championship = current_user.championships.find(params[:championship_id])
    @game = @championship.games.build(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to championship_games_url(@championship), notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @championship = current_user.championships.find(params[:championship_id])
    @game = @championship.games.find(params[:id])

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to championship_games_url(@championship), notice: 'Game was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @championship = current_user.championships.find(params[:championship_id])
    @game = @championship.games.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to championship_games_url(@championship) }
      format.json { head :no_content }
    end
  end
end
