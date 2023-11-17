import Foundation

enum ConvertCityName: String {
    case seoul = "Seoul"
    case daegu = "Daegu"
    case busan = "Busan"
    case sokcho = "Sokcho"
    case suwon = "Suwon-si"
    case jeju = "Jeju City"
    
    var cityName: String {
        switch self {
        case .seoul:return "서울특별시"
        case .daegu:return "대구광역시"
        case .busan:return "부산광역시"
        case .sokcho:return "속초시"
        case .suwon:return "수원시"
        case .jeju:return "제주특별자치도"
        }
    }

}
