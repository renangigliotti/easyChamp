class GamesController < ApplicationController
  # GET /games
  # GET /games.json
  def index
    @championship = Championship.find(params[:championship_id])
    @games = @championship.games.where("").paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @championship = Championship.find(params[:championship_id])
    @game = @championship.games.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @championship = Championship.find(params[:championship_id])
    @game = @championship.games.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @championship = Championship.find(params[:championship_id])
    @game = @championship.games.find(params[:id])
  end

  # POST /games
  # POST /games.json
  def create
    @championship = Championship.find(params[:championship_id])
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

  # PUT /games/1
  # PUT /games/1.json
  def update
    @championship = Championship.find(params[:championship_id])
    @game = Game.find(params[:id])

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

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @championship = Championship.find(params[:championship_id])
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to championship_games_url(@championship) }
      format.json { head :no_content }
    end
  end
end
