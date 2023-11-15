import Foundation

class GetInfoService {
    //싱글톤 객체 생성
    static let shared = GetInfoService()
    private init(){}
    
    func makeRequest(city: String) -> URLRequest{
        let baseUrl = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.baseURL) as? String ?? ""
        let apiKey = Bundle.main.object(forInfoDictionaryKey: Config.Keys.Plist.apiKey) as? String ?? ""
        let url = URL(string: baseUrl + "\(city)&appid=\(apiKey)")!
        var request = URLRequest(url: url)
        let header = ["Content-Type" : "application/json"]
        header.forEach{
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
}
