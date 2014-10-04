
require 'sinatra'
require 'yahoo_weatherman'

def determine_weather(location)
	client = Weatherman::Client.new
	weather = client.lookup_by_location(location).condition['text']
	return weather.downcase
end

def determine_location(location)
	client = Weatherman::Client.new
	location_info = client.lookup_by_location(location).location
	city = location_info['city'].capitalize
	return city
end

get '/' do
	erb :home
end

post '/weather' do
	@post = params[:post]["location"]
	@weather = determine_weather(@post)
	@location = determine_location(@post)

	case @weather
		when 'sunny'
			erb :weather
		when 'cloudy'
			erb :weather
		when 'snowy'
			erb :weather
		when 'fair'
			erb :weather
		when 'partly cloudy'
			@weather = 'cloudy'
			erb :weather
		when 'rainy'
			erb :weather
		else
			erb :default
	end
end