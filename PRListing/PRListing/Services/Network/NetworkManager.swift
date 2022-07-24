//
//  NetworkManager.swift
//  PRListing
//
//  Created by Tania Jasam on 24/07/22.
//

import Foundation
import Combine

protocol NetworkRequestable {
    func dataTask<T: Decodable>(with requestConfig: RequestConfiguration, type: T.Type) -> Future<[T], Error>
}

class NetworkManager: NetworkRequestable {
    private init() {}
    
    static var sharedInstance: NetworkRequestable = NetworkManager()
    
    private var cancellables = Set<AnyCancellable>()
    
    func dataTask<T>(with requestConfig: RequestConfiguration, type: T.Type) -> Future<[T], Error> where T : Decodable {
        return Future<[T], Error> { [weak self] promise in
            
            guard let self: NetworkManager = self else {
                return promise(.failure(NetworkError.unknown))
            }
            
            guard let url: URL = requestConfig.getURL() else {
                return promise(.failure(NetworkError.invalidURL))
            }
            
            var request: URLRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData)
            request.httpMethod = requestConfig.getMethod().rawValue
            request.allHTTPHeaderFields = requestConfig.getHeaders()
            if let requestBody: [String: Any] = requestConfig.getRequestBody() {
                switch requestConfig.getMethod() {
                case .GET:
                    if let requestURL: URL = request.url,
                       var urlComponents: URLComponents = URLComponents(url: requestURL, resolvingAgainstBaseURL: false) {
                        var items: [URLQueryItem] = urlComponents.queryItems ?? []
                        
                        requestBody.forEach({ (key: String, value: Any) in
                            items.append(URLQueryItem(name: key, value: value as? String))
                        })
                        
                        urlComponents.queryItems = items
                        request.url = urlComponents.url
                    }
                    
                case .POST:
                    if let httpBody: Data = try? JSONSerialization.data(withJSONObject: requestBody) {
                        request.httpBody = httpBody
                    }
                    
                default:
                    break
                }
                
            }
            
            let decoder: JSONDecoder = JSONDecoder()
            
            URLSession.shared.dataTaskPublisher(for: request)
                .tryMap { (data, response) -> Data in
                    guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw NetworkError.apiFailure
                    }
                    return data
                }
                .decode(type: [T].self, decoder: decoder)
                .sink(receiveCompletion: { (completion) in
                    if case let .failure(error) = completion {
                        switch error {
                        case let decodingError as DecodingError:
                            promise(.failure(decodingError))
                        case let apiError as NetworkError:
                            promise(.failure(apiError))
                        default:
                            promise(.failure(NetworkError.unknown))
                        }
                    }
                }, receiveValue: { promise(.success($0)) })
                .store(in: &self.cancellables)
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case apiFailure
    case unknown
}


