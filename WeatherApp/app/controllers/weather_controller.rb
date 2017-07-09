class WeatherController < ApplicationController
  def index
  end


  def find
    @result = []
    @forecast = []
    @locations = Location.within_bounding_box(Geocoder::Calculations.bounding_box(params[:location],params[:miles]))
    ForecastIO.configure do |configuration|
        configuration.api_key = '4406bd2ab2d478862f47da3dfb59e1d4'
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

    #Logic to spot the points of interests around each of the above places
    @client = GooglePlaces::Client.new('AIzaSyCZe4Xk1xu_4b-ZM-7X8YCe_xHJwRP39yo')
    @interests =   @client.spots(37.8267, -122.423)



    respond_to do |format|
      #format.html { redirect_to "/weather/index" }
      format.js
    end



  end
end
