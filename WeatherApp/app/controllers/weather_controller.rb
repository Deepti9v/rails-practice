class WeatherController < ApplicationController
  def index
  end


  def find
    @result = []
    @locations = Location.within_bounding_box(Geocoder::Calculations.bounding_box(params[:location],params[:miles]))
    @locations.each {|x|  @result << {'latitude' => x.latitude, 'longitude'=>x.longitude}}
    gon.location = params[:location]
    gon.miles = params[:miles]
    @response = Weather.lookup_by_location('San Francisco, CA', Weather::Units::FAHRENHEIT)
    render "/weather/index"
  end

end
