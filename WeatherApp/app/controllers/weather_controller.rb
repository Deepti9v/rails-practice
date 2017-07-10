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

    @client = GooglePlaces::Client.new('AIzaSyCZe4Xk1xu_4b-ZM-7X8YCe_xHJwRP39yo')

    @locations.each do |x|
      @interests =   @client.spots(x.latitude,x.longitude)
      @result <<
           {'address' => x.address,
             'latitude' => x.latitude,
             'longitude'=>x.longitude,
             'weather' => ForecastIO.forecast(x.latitude, x.longitude).daily.data.first(5),
             'interests' => @interests
           }
    end

    @job = @result
    gon.watch.job = @job

    puts "****"
    puts @interests.to_json
    puts "****"




    respond_to do |format|
      #format.html { redirect_to "/weather/index" }
      format.js
    end



  end
end
