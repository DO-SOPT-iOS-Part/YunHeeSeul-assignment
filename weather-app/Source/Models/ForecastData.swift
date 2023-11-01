import Foundation

struct ForecastData{
    let day: String
    let weatherIcon: String
    let percentage: String
    let lowest: String
    let progressBar: String
    let highest: String
    
    init(day: String, weatherIcon: String, percentage: String, lowest: String, progressBar: String, highest: String) {
        self.day = day
        self.weatherIcon = weatherIcon
        self.percentage = percentage
        self.lowest = lowest
        self.progressBar = progressBar
        self.highest = highest
    }
    
    static let forecastData: [ForecastData] = [
        .init(day: "오늘", weatherIcon: "sun.max.fill", percentage: "", lowest: "15º", progressBar: "progressBar", highest: "29º"),
        .init(day: "월", weatherIcon: "cloud.rain.fill", percentage: "60%", lowest: "18º", progressBar: "progressBar", highest: "27º"),
        .init(day: "화", weatherIcon: "cloud.rain.fill", percentage: "60%", lowest: "20º", progressBar: "progressBar", highest: "25º"),
        .init(day: "수", weatherIcon: "cloud.rain.fill", percentage: "70%", lowest: "17º", progressBar: "progressBar", highest: "25º"),
        .init(day: "목", weatherIcon: "cloud.rain.fill", percentage: "50%", lowest: "17º", progressBar: "progressBar", highest: "25º"),
        .init(day: "금", weatherIcon: "cloud.sun.fill", percentage: "", lowest: "20º", progressBar: "progressBar", highest: "26º"),
        .init(day: "토", weatherIcon: "sun.max.fill", percentage: "", lowest: "18º", progressBar: "progressBar", highest: "25º"),
        .init(day: "일", weatherIcon: "cloud.rain.fill", percentage: "50%", lowest: "13º", progressBar: "progressBar", highest: "21º"),
        .init(day: "월", weatherIcon: "cloud.rain.fill", percentage: "50%", lowest: "12º", progressBar: "progressBar", highest: "19º"),
        .init(day: "화", weatherIcon: "sun.max.fill", percentage: "", lowest: "18º", progressBar: "progressBar", highest: "25º"),
        .init(day: "수", weatherIcon: "sun.max.fill", percentage: "", lowest: "18º", progressBar: "progressBar", highest: "25º")
    ]
}
