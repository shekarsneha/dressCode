
import Foundation

class WeatherURLManager
{
	class func getCityWeatherURL(city: String) -> URL?
	{
		let urlString = "http://api.openweathermap.org/data/2.5/weather?q=\(city)&units=metric&APPID=acebdb4548ced12a28df4ccf585c3466"

		return URL(string: urlString)
	}
}
