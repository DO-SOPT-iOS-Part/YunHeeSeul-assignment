import Foundation

struct WeatherInfoData{
    let myLocation : String
    let city : String
    let weather : String
    let temperature : Double
    let high : Double
    let low : Double
    
    init(myLocation: String, city: String, weather: String, temperature: Double, high: Double, low: Double) {
        self.myLocation = myLocation
        self.city = city
        self.weather = weather
        self.temperature = temperature - 273.15
        self.high = high - 273.15
        self.low = low - 273.15
    }
}
