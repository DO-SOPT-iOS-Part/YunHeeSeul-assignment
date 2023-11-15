enum NetworkError: Int, Error, CustomStringConvertible {
    var description: String { self.errorDescription }
    case requstEncodingError
    case responseDecodingError
    case responseError
    case unknownError
    case geocodeError = 400
    case apiKeyError = 401
    case internalServerError = 500
    case notFoundError = 404
    
    var errorDescription: String {
        switch self {
        case .geocodeError: return "잘못된 지역코드입니다."
        case .apiKeyError: return "잘못된 API Key입니다."
        case .requstEncodingError: return "REQUEST_ENCODING_ERROR"
        case .responseError: return "RESPONSE_ERROR"
        case .responseDecodingError: return "RESPONSE_DECODING_ERROR"
        case .unknownError: return "UNKNOWN_ERROR"
        case .internalServerError: return "500:INTERNAL_SERVER_ERROR"
        case .notFoundError: return "404:NOT_FOUND_ERROR"
        }
    }
}
