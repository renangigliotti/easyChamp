class ChampionshipsController < ApplicationController

  def index
    @championships = current_user.championships.paginate(:page => params[:page], :per_page => 15)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @championships }
    end
  end

  def show
    @championship = current_user.championships.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @championship }
    end
  end

  def new
    @championship = Championship.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @championship }
    end
  end

  def edit
    @championship = current_user.championships.find(params[:id])
  end

  def create
    @championship = Championship.new(params[:championship])

    respond_to do |format|
      if @championship.save
        current_user.championships <<  @championship

        format.html { redirect_to championship_path(@championship), notice: 'Championship was successfully created.' }
        format.json { render json: @championship, status: :created, location: @championship }
      else
        format.html { render action: "new" }
        format.json { render json: @championship.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @championship = current_user.championships.find(params[:id])

    respond_to do |format|
      if @championship.update_attributes(params[:championship])
        format.html { redirect_to championship_path(@championship), notice: 'Championship was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @championship.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @championship = current_user.championships.find(params[:id])
    @championship.destroy

    respond_to do |format|
      format.html { redirect_to championships_path }
      format.json { head :no_content }
    end
  end
end