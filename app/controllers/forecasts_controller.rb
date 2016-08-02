class ForecastsController < ApplicationController
  def index
    city = params["city"]
    state = params["state"]
    @data = Unirest.get("https://query.yahooapis.com/v1/public/yql?q=select%20*%20from%20weather.forecast%20where%20woeid%20in%20(select%20woeid%20from%20geo.places(1)%20where%20text%3D%22#{city}%2C%20#{state}%22)&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys").body
    @temperature = @data["query"]["results"]["channel"]["item"]["condition"]["temp"]
    @description = @data["query"]["results"]["channel"]["item"]["description"]
    @forecast_days = @data["query"]["results"]["channel"]["item"]["forecast"]
    render 'index.html.erb'
  end
end
