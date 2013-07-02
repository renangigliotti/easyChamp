class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :loadChampionships

  def loadChampionships
  	@championships = Championship.all
  end
end
