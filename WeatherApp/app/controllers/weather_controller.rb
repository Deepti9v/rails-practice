class WeatherController < ApplicationController
  def index
  end


  def find
    @result = []
    @forecast = []
    @locations = Location.within_bounding_box(Geocoder::Calculations.bounding_box(params[:location],params[:miles]))
    #gon.location = params[:location]
    ForecastIO.configure do |configuration|
        configuration.api_key = '31fb94122dc29e9b499edb0f20b672b9'
    end
    @forecast = ForecastIO.forecast(37.8267, -122.423)
    @locations.each {|x|  @result <<
          {'address' => x.address,
            'latitude' => x.latitude,
            'longitude'=>x.longitude,
            'weather' => ForecastIO.forecast(x.latitude, x.longitude).daily.data.first(5)
          }
        }

    @job = @result
    gon.watch.job = @job


    puts "**************"
    puts @result
    puts "**************"

    respond_to do |format|
      #format.html { redirect_to "/weather/index" }
      format.js
    end



  end
end
