import Foundation

struct WeatherInfoData{
    let myLocation : String
    let city : String
    let weather : String
    let temperature : String
    let highNLow : String
    
    init(myLocation: String, city: String, weather: String, temperature: String, highNLow: String) {
        self.myLocation = myLocation
        self.city = city
        self.weather = weather
        self.temperature = temperature
        self.highNLow = highNLow
    }
    
    static let weatherInfoData: [WeatherInfoData] = [
        .init(myLocation: "나의 위치", city: "서울특별시", weather: "흐림", temperature: "10º", highNLow: "최고:21º 최저:9º"),
        .init(myLocation: "영등포구", city: "서울특별시", weather: "흐림", temperature: "10º", highNLow: "최고:21º 최저:9º"),
        .init(myLocation: "용산구", city: "서울특별시", weather: "흐림", temperature: "10º", highNLow: "최고:21º 최저:9º"),
        .init(myLocation: "마포구", city: "서울특별시", weather: "흐림", temperature: "10º", highNLow: "최고:21º 최저:9º"),
        .init(myLocation: "서대문구", city: "서울특별시", weather: "흐림", temperature: "10º", highNLow: "최고:21º 최저:9º"),
        .init(myLocation: "강남구", city: "서울특별시", weather: "흐림", temperature: "10º", highNLow: "최고:21º 최저:9º")
    ]
}
