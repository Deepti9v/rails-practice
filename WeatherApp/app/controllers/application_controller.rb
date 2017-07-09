class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :set_global_variables

  def set_global_variables
    @pic = {    "Clear throughout the day." => "/assets/sunny.png" ,
                "Partly cloudy throughout the day." => "/assets/partly_cloudy.png",
                "Partly cloudy in the morning." => "/assets/cloudy.png",
                "Dry throughout the day." => "/assets/drought.png"
            }
  end

end
