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
        request.httpMethod = "GET"
        let header = ["Content-Type" : "application/json"]
        header.forEach{
            request.addValue($0.value, forHTTPHeaderField: $0.key)
        }
        return request
    }
    
    func GetCurrentWeatherData(city: String) async throws -> CurrentWeatherData? {
        do{
            let request = self.makeRequest(city: city)
            let (data, response) = try await URLSession.shared.data(for: request)
            print("request : \n\(request)")
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.responseError
            }
            print("reponse : \n\(httpResponse)")
            return parseCurrentWeatherData(data: data)
        }catch{
            throw error
        }
    }
    
    func parseCurrentWeatherData(data: Data) -> CurrentWeatherData? {
        do{
            let jsonDecoder = JSONDecoder()
            let result = try jsonDecoder.decode(CurrentWeatherData.self, from: data)
            return result
        }catch{
            print("parseError: \(error)")
            return nil
        }
    }
}
