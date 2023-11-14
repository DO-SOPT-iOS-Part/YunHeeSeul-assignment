import Foundation

struct HourlyWeatherData{
    let time : String
    let icon : String
    let temperature : String
    
    init(time: String, icon: String, temperature: String) {
        self.time = time
        self.icon = icon
        self.temperature = temperature
    }
    
    static let hourlyWeatherData : [HourlyWeatherData] = [
        .init(time: "Now", icon: "moonNcloud", temperature: "21º"),
        .init(time: "10시", icon: "rain", temperature: "21º"),
        .init(time: "11시", icon: "heavyRain", temperature: "19º"),
        .init(time: "12시", icon: "thunder", temperature: "19º"),
        .init(time: "13시", icon: "rainNsun", temperature: "19º"),
        .init(time: "14시", icon: "moonNcloud", temperature: "18º"),
        .init(time: "15시", icon: "rain", temperature: "18º"),
        .init(time: "16시", icon: "heavyRain", temperature: "18º"),
        .init(time: "17시", icon: "thunder", temperature: "18º"),
        .init(time: "18시", icon: "rainNsun", temperature: "18º")
    ]
}
