class WeatherController < ApplicationController
  def index
  end


  def find
    @result = []
    @forecast = []
    @locations = Location.within_bounding_box(Geocoder::Calculations.bounding_box(params[:location],params[:miles]))
    #gon.location = params[:location]
    ForecastIO.configure do |configuration|
        configuration.api_key = '7e760ff33a6c465801375b47a8db15c2'
    end
    @forecast = ForecastIO.forecast(37.8267, -122.423)
    @locations.each {|x|  @result <<
          {'address' => x.address,
            'latitude' => x.latitude,
            'longitude'=>x.longitude,
            'weather' => ForecastIO.forecast(x.latitude, x.longitude).daily
          }
        }
    puts @result[0]['weather'].data[0]
    puts "**************"

    respond_to do |format|
      #format.html { redirect_to "/weather/index" }
      format.js
    end



  end
end
