class TeamsController < ApplicationController

  def index
    @championship = current_user.championships.find(params[:championship_id])
    @teams = @championship.teams.where("").paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @teams }
    end
  end

  def show
    @championship = current_user.championships.find(params[:championship_id])
    @team = @championship.teams.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @team }
    end
  end

  def new
    @championship = current_user.championships.find(params[:championship_id])
    @team = @championship.teams.build
    load_logos

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @team }
    end
  end

  def edit
    @championship = current_user.championships.find(params[:championship_id])
    @team = @championship.teams.find(params[:id])
    load_logos
  end

  def create
    @championship = current_user.championships.find(params[:championship_id])
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

  def update
    @championship = current_user.championships.find(params[:championship_id])
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

  def destroy
    @championship = current_user.championships.find(params[:championship_id])
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
    Dir.glob("#{Rails.root}/app/assets/images/*.png").each do |l|
      @logos << l.split('/').last
    end
    @logos.sort!
  end
end
