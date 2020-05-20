//
//  CovidAPI.swift
//  COVIDStatus
//
//  Created by Josue Hernandez Gonzalez on 11-04-20.
//  Copyright © 2020 Josue Hernandez Gonzalez. All rights reserved.
//

import Cocoa
import Combine

class CovidAPI: CovidAPIProvider {
    
    private let baseURL = "https://corona.lmao.ninja/v2"
    
    private enum EndPoint: String {
        case allCountries = "/all"
    }
    
    private enum Method: String {
        case GET
    }
    
    func fetchDataFromServer(completion: @escaping ((Result<CovidTotal, APIError>) -> Void)) {
        request(endpoint: .allCountries, method: .GET, completion: completion)
    }
    
    private func request<T: Codable>(endpoint: EndPoint, method: Method, completion: @escaping((Result<T,APIError>) -> Void)) {
        let path = "\(baseURL)\(endpoint.rawValue)"
        
        guard let url = URL(string: path) else { completion(.failure(.internalError)); return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        
        call(with: request, completion: completion)
    }

    private func call<T: Codable>(with request:URLRequest, completion: @escaping((Result<T,APIError>) -> Void)) {
        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil
                else { completion(.failure(.serverError)); return }
            do {
                guard let  data = data
                    else { completion(.failure(.serverError)); return }
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(Result.success(object))
            } catch {
                completion(Result.failure(.parsingError))
            }
        }
        dataTask.resume()
    }
    
    // MARK: Combine
    
    func fetchDataFromServer() -> AnyPublisher<CovidTotal, APIError> {
        return callTwo(.allCountries, method: .GET)
    }
    
    private func request(for endpoint: EndPoint, method: Method) -> URLRequest {
        let path = "\(baseURL)\(endpoint.rawValue)"
        guard let url = URL(string: path) else { preconditionFailure("BAD URL") }
        
        var request = URLRequest(url: url)
        request.httpMethod = "\(method)"
        request.allHTTPHeaderFields = ["Content-Type":"application/json"]
        return request
    }
 
    private func callTwo<T: Codable>(_ endPoint: EndPoint, method: Method) -> AnyPublisher<T,APIError> {
        let urlRequest = request(for: endPoint, method: method)
        
        return URLSession.shared.dataTaskPublisher(for: urlRequest)
            .mapError{ _ in APIError.serverError }
            .map{ $0.data }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError{ _ in APIError.parsingError }
            .eraseToAnyPublisher()
    }
    
}
