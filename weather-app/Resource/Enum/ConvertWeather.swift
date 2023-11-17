import Foundation

enum ConvertWeather: String {
    case rain = "Rain"
    case cloud = "Clouds"
    case wind = "Wind"
    case mist = "Mist"
    case thunderStorm = "Thunderstorm"
    case drizzle = "Drizzle"
    case snow = "Snow"
    case clear = "Clear"
    
    var weather: String {
        switch self {
        case .rain: return "비내림"
        case .cloud: return "흐림"
        case .wind: return "강풍"
        case .mist: return "안개"
        case .thunderStorm: return "천둥번개"
        case .drizzle: return "비내림"
        case .snow: return "눈내림"
        case .clear: return "맑음"
        }
    }
}
