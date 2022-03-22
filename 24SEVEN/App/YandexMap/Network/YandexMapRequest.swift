
import Foundation
import Alamofire

internal typealias Complition<Model: Codable> = (DataResponse<Model,AFError>) -> Void

class NetworkManagerYandex {
    static let shared: NetworkManagerYandex = NetworkManagerYandex()
    
    internal func makeRequest<Model: Codable>(url: String, method: HTTPMethod = .get, params: [String: AnyHashable], headers: HTTPHeaders? = nil, complition: @escaping Complition<Model>) {
        let request = AF.request(url, method: method, parameters: params)
        request.responseDecodable(of: Model.self) { response in
            complition(response)
        }
    }
}

extension NetworkManagerYandex {
    struct YandexMap {
        internal static func makeRequest<Model: Codable>(url: String = "", method: HTTPMethod = .get, params: [String: AnyHashable], headers: HTTPHeaders? = nil , complition: @escaping (DataResponse<Model, AFError>) -> Void) {
            let _url =  "https://geocode-maps.yandex.ru/1.x/" + url
            NetworkManagerYandex.shared.makeRequest(url: _url, method: method, params: params, headers: headers, complition: complition)
        }
       
        static func yandexMapData(params: [String: AnyHashable] = [:], complition: @escaping Complition<YandexModel>) {
            YandexMap.makeRequest(method: .get, params: params, complition: complition)
        }
    }
}
