class TeamsController < ApplicationController
  # GET /teams
  # GET /teams.json
  def index
    @championship = Championship.find(params[:championship_id])
    @teams = @championship.teams.where("").paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  # GET /teams/1
  # GET /teams/1.json
  def show
    @championship = Championship.find(params[:championship_id])
    @team = @championship.teams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/new
  # GET /teams/new.json
  def new
    @championship = Championship.find(params[:championship_id])
    @team = @championship.teams.build
    load_logos

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  # GET /teams/1/edit
  def edit
    @championship = Championship.find(params[:championship_id])
    @team = @championship.teams.find(params[:id])
    load_logos
  end

  # POST /teams
  # POST /teams.json
  def create
    @championship = Championship.find(params[:championship_id])
    @team = @championship.teams.build(params[:team])

    respond_to do |format|
      if @team.save
        format.html { redirect_to championship_teams_url(@championship), notice: 'Team was successfully created.' }
        format.json { render json: @team, status: :created, location: @team }
      else
        format.html { render action: "new" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /teams/1
  # PUT /teams/1.json
  def update
    @championship = Championship.find(params[:championship_id])
    @team = @championship.teams.find(params[:id])

    respond_to do |format|
      if @team.update_attributes(params[:team])
        format.html { redirect_to championship_teams_url(@championship), notice: 'Team was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @team.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /teams/1
  # DELETE /teams/1.json
  def destroy
    @championship = Championship.find(params[:championship_id])
    @team = destroy.teams.find(params[:id])
    @team.destroy

    respond_to do |format|
      format.html { redirect_to championship_teams_url(@championship) }
      format.json { head :no_content }
    end
  end

  private

  def load_logos
    @logos = Array.new
    Dir.glob("app/assets/images/*.png").each do |l|
      @logos << l.split('/').last
    end
    @logos.sort!
  end
end
