class GameController < ApplicationController
  def index
  end

  def process_points
    @link_id = params[:link_id]
    if @link_id == "Casino"
      @points = rand(10..20)
    elsif @link_id == "House"
      @points = rand(20..30)
    elsif @link_id == "Farm"
      @points = rand(0..5)
    elsif @link_id == "Cave"
      @points = rand(5..10)
    end

    session[:points] ||= 0
    session[:points] = session[:points] + @points;
    @gold = session[:points];
  end
end
